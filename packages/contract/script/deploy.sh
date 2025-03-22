#!/bin/bash

set -e

# Constants
RPC_URL="https://node-2.seismicdev.net/rpc"
FAUCET_URL="https://faucet-2.seismicdev.net/"
CONTRACT_PATH="src/Walnut.sol:Walnut"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' 

print_step() {
    echo -e "\n${BLUE}Step $1: $2${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

check_balance() {
    local address=$1
    local balance_json=$(curl -s -X POST "$RPC_URL" \
        -H "Content-Type: application/json" \
        -d '{
            "jsonrpc":"2.0",
            "method":"eth_getBalance",
            "params":["'$address'", "latest"],
            "id":1
        }')
    
    local hex_result=$(echo "$balance_json" | grep -o '"result":"[^"]*"' | cut -d'"' -f4)
    if [ "$hex_result" == "0x0" ]; then
        echo -e "${RED}Error: Address not funded. Please check if your faucet transaction went through.${NC}"
        echo -e "${RED}If the issue persists, message @lyronc on Telegram.${NC}"
        exit 1
    fi
}

# Generate new wallet
print_step "1" "Generating new dev wallet"
keypair=$(cast wallet new)
address=$(echo "$keypair" | grep "Address:" | awk '{print $2}')
privkey=$(echo "$keypair" | grep "Private key:" | awk '{print $3}')
print_success "Success"

# Seed wallet using faucet
print_step "2" "Funding wallet"
echo -e "Please visit: ${GREEN}$FAUCET_URL${NC}"
echo -e "Enter this address: ${GREEN}$address${NC}"
echo -ne "${BLUE}Press Enter when done...${NC}"
read -r

# Verify funds
print_step "3" "Verifying funds (takes a few seconds)"
sleep 4
check_balance "$address"
print_success "Success"

# Deploy contract
print_step "4" "Deploying contract"
deploy_output=$(sforge create \
    --rpc-url "$RPC_URL" \
    --private-key "$privkey" \
    --broadcast \
    "$CONTRACT_PATH" \
    --constructor-args 3 0)

# Extract and print deployment info
contract_address=$(echo "$deploy_output" | grep "Deployed to:" | awk '{print $3}')
tx_hash=$(echo "$deploy_output" | grep "Transaction hash:" | awk '{print $3}')
print_success "Success"

# Print final deployment summary
print_step "5" "Deployment Summary"
echo -e "Contract Address:     ${GREEN}$contract_address${NC}"
echo -e "Transaction Hash:  ${GREEN}$tx_hash${NC}"
print_success "Success. You just deployed your first contract on Seismic!" 
