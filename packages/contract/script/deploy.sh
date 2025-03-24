#!/bin/bash

set -e

source /Users/lyronctk/Documents/projects/seismic/try-devnet/packages/common/print.sh
source /Users/lyronctk/Documents/projects/seismic/try-devnet/packages/common/wallet.sh

CONTRACT_PATH="src/Counter.sol:Counter"
DEPLOY_FILE="out/deploy.txt"

prelude() {
    echo -e "${BLUE}Deploy an encrypted smart contract in under 1 minute.${NC}"
    echo -e "It's a Counter contract that only reveals the counter once it's >=5."
    echo -ne "Press Enter to continue..."
    read -r
}

prelude

dev_wallet
address=$DEV_WALLET_ADDRESS
privkey=$DEV_WALLET_PRIVKEY

print_step "4" "Deploying contract"
deploy_output=$(sforge create \
    --rpc-url "$RPC_URL" \
    --private-key "$privkey" \
    --broadcast \
    "$CONTRACT_PATH" \
    --constructor-args 5)

print_step "5" "Summarizing deployment"
contract_address=$(echo "$deploy_output" | grep "Deployed to:" | awk '{print $3}')
tx_hash=$(echo "$deploy_output" | grep "Transaction hash:" | awk '{print $3}')
echo "$contract_address" >$DEPLOY_FILE
echo -e "Contract Address:     ${GREEN}$contract_address${NC}"
echo -e "Transaction Hash:  ${GREEN}$tx_hash${NC}"

echo -e "\n"
print_success "Success. You just deployed your first contract on Seismic!"
