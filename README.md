# chain_testing
Eth chain testing

## Usage
Inside docker-compose.toml, update:   
`GETH_REPO_URL`  
`GETH_BRANCH_NAME`  
`SPAMMER_IMAGE_URL`  

Update the genesis file for the miner:  
`./geth/genesis.json`  

Update the config and ABI for the tx spammer:  
`./spammer/config.toml`  
`./spammer/test_abi.json`  


Tweak docker-compose env variables as needed:  
`./docker-compose.env`

Set local Postgres env variables:  
`POSTGRES_CLONE_URL`  
`POSTGRES_BRANCH_NAME`  
`POSTGRES_BUILD_PATH`  
`POSTGRES_NAME`  
`POSTGRES_TAG`  
`POSTGRES_VOLUME_HOST_PATH`  
`POSTGRES_VOLUME_DST_PATH`  
`POSTGRES_SERVICE_NAME`  
`POSTGRES_PASSWORD`  


Run:  
`./start.sh`