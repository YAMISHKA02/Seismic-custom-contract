import chalk from 'chalk'
import fs from 'fs'
import { join } from 'path'
import {
  createShieldedWalletClient,
  getShieldedContract,
  seismicDevnet,
} from 'seismic-viem'
import { AbiFunction, AbiParameter, http } from 'viem'
import { privateKeyToAccount } from 'viem/accounts'

const CONTRACT_NAME = 'Counter'
const CONTRACT_DIR = join(__dirname, '../../contract')
const RPC_URL = 'https://node-2.seismicdev.net/rpc'

type BaseTx = {
  to: string
  gas?: bigint
  gasPrice?: bigint
  nonce?: number
  value?: bigint
  data: string
}

type PlaintextTx = BaseTx

type ShieldedTx = BaseTx & {
  encryptionPubkey: string
}

function parseCalldata(calldata: string, abiFunc: AbiFunction) {
  let params = calldata.slice(10)

  const paramValues: string[] = []
  while (params.length > 0) {
    paramValues.push('0x' + params.slice(0, 64).replace(/^0+/, ''))
    params = params.slice(64)
  }

  const result: Record<string, string> = {}

  const abiEntry = abiFunc
  abiEntry.inputs.forEach((input: AbiParameter, i: number) => {
    result[input.name as string] = paramValues[i]
  })

  return result
}

function displayPlaintextTx(plaintextTx: PlaintextTx, abiFunc: AbiFunction) {
  const parsedData = parseCalldata(plaintextTx.data, abiFunc)

  console.log('- CONSTRUCTING TRANSACTION...')
  console.log('----------------------------------')
  console.log(`to:        ${plaintextTx.to}`)
  Object.entries(parsedData).forEach(([key, value]) => {
    const padding = ' '.repeat(10 - key.length)
    console.log(`${key}:${padding}${chalk.red(value)}`)
  })
  console.log('----------------------------------\n')
}

function displayShieldedTx(shieldedTx: ShieldedTx) {
  console.log('- ENCRYPTING TRANSACTION...')
  console.log('----------------------------------')
  console.log(`to:        ${shieldedTx.to}`)
  console.log(`data:      ${chalk.green(shieldedTx.data)}`)
  console.log('----------------------------------\n')
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

async function main() {
  const [contractAddr, privkey] = process.argv.slice(2)

  const abiFile = join(
    CONTRACT_DIR,
    'out',
    `${CONTRACT_NAME}.sol`,
    `${CONTRACT_NAME}.json`
  )

  const abi = JSON.parse(fs.readFileSync(abiFile, 'utf8')).abi

  const walletClient = await createShieldedWalletClient({
    chain: seismicDevnet,
    transport: http(RPC_URL),
    account: privateKeyToAccount(privkey as `0x${string}`),
  })

  const contract = getShieldedContract({
    abi: abi,
    address: contractAddr,
    client: walletClient,
  })

  console.log('Incrementing by 3')
  const { plaintextTx, shieldedTx } = await contract.dwrite.increment([3])
  displayPlaintextTx(plaintextTx, abi[2])
  displayShieldedTx(shieldedTx)
  await contract.write.increment([3])
  await sleep(10000)

  try {
    const result = await contract.read.getNumber([])
  } catch (_) {
    console.log("You can't read the number if it's below the threshold:")
  }

  console.log('Incrementing by 2')
  await contract.write.increment([2])
  await sleep(10000)

  console.log('Now you can read number')
  const result = await contract.read.getNumber([])
  console.log('result', result)
}

main()
