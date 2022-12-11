# NGAEN token (SGN) 

## Intro
NGAEN token is the ERC20 token of SaigonDAO.

## Getting Started

### Requirements

- git
- Nodejs
- Yarn

### Quick start

```bash
git clone https://github.com/UsuaOSilver/saigondao.git
cd saigondao
yarn
```

## Usage

Deploy:
        yarn hardhat deploy
        
## Deployment to a testnet or mainnet

1. Setup environment variables
2. Get testnet ETH at https://faucets.chain.link/
3. Deploy
        yarn hardhat deploy --network GOERLI_RPC_URL
        
## Verify on etherscan

Auto verification for goerli contracts with your ETHERSCAN_API_KEY.

Manual verification
        yarn hardhat verify --constructor-args arguments DEPLOYED_CONTRACT_ADDRESS


