#!/bin/bash

set -e

source ../../config.sh
source ../common/print.sh
source ../common/wallet.sh

CONTRACT_PATH="src/HelloWorld.sol:HelloWorld"
DEPLOY_FILE="out/deploy.txt"

prelude() {
    echo -e ""
    echo -e "${BLUE}Custom contract from Mishka_shishka${NC}"
    echo -e ""
    echo -e "It's a Modified Hello World contract!"
    sleep 3
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
    "$CONTRACT_PATH")

print_success "Success."

print_step "5" "Summarizing deployment"
contract_address=$(echo "$deploy_output" | grep "Deployed to:" | awk '{print $3}')
tx_hash=$(echo "$deploy_output" | grep "Transaction hash:" | awk '{print $3}')
echo "$contract_address" >"$DEPLOY_FILE"
echo -e "Contract Address: ${GREEN}$contract_address${NC}"
echo -e "Contract Link: ${GREEN}$EXPLORER_URL/address/$contract_address${NC}"

echo -e "\n"
print_success "Success. You just deployed your custom contract on Seismic!"
