#!/bin/bash

set -e

source ../common/print.sh
source ../common/wallet.sh

contract_address=$(cat ../contract/out/deploy.txt)

prelude() {
    echo -e "${BLUE}Transact with an encrypted smart contract in under 1 minute.${NC}"
    echo -e "Assumes you already deployed via packages/contract/."
    echo -e "It'll increment the counter by 3, try to read it, but fail because 3 < 5."
    echo -e "Then it'll increment by 2, try to read it, and succeed because 5 >= 5."
    echo -ne "Press Enter to continue..."
    read -r
}

prelude

dev_wallet
address=$DEV_WALLET_ADDRESS
privkey=$DEV_WALLET_PRIVKEY

bun run src/index.ts $contract_address $privkey
