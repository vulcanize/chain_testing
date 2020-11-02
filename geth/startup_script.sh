#!/bin/sh

## Passed in from environment variables:
HOST_NAME=${HOST_NAME:-0.0.0.0}
PORT=${PORT:-8545}
NETWORK_ID=${NETWORK_ID:-420}
VOLUME_PATH=${VOLUME_PATH:-/mnt/data}
GENESIS_FILE=${GENESIS_FILE:-/mnt/data/genesis.json}

TARGET_GAS_LIMIT=${TARGET_GAS_LIMIT:-8000000}
TX_INGESTION=${TX_INGESTION:-false}
TX_INGESTION_DB_HOST=${TX_INGESTION_DB_HOST:-localhost}
TX_INGESTION_DB_PASSWORD=${TX_INGESTION_DB_PASSWORD:-test}
TX_INGESTION_DB_USER=${TX_INGESTION_DB_USER:-test}
TX_INGESTION_POLL_INTERVAL=${TX_INGESTION_POLL_INTERVAL:-3s}
POSTGRES_ETHDB=${POSTGRES_ETHDB:-false}
POSTGRES_HOST=${POSTGRES_HOST:-postgres}
POSTGRES_DATABASE=${POSTGRES_DATABASE:-ethdb}
ETHER_BASE=${ETHER_BASE:-0x0000000000000000000000000000000000000000}

echo "Initializing new genesis block..."
geth init --datadir $VOLUME_PATH $GENESIS_FILE

echo "Starting miner..."
geth --dev \
  --datadir $VOLUME_PATH \
  --mine \
  --minerthreads=1 \
  --etherbase=$ETHER_BASE \
  --rpc \
  --rpcaddr $HOST_NAME \
  --rpcvhosts='*' \
  --rpccorsdomain='*' \
  --rpcport $PORT \
  --networkid $NETWORK_ID \
  --ipcdisable \
  --rpcapi 'eth,net' \
  --gasprice '0' \
  --targetgaslimit $TARGET_GAS_LIMIT \
  --nousb \
  --gcmode=archive \
  --verbosity "6" \
  --txingestion.enable=$TX_INGESTION \
  --txingestion.dbhost=$TX_INGESTION_DB_HOST \
  --txingestion.pollinterval=$TX_INGESTION_POLL_INTERVAL \
  --txingestion.dbuser=$TX_INGESTION_DB_USER \
  --txingestion.dbpassword=$TX_INGESTION_DB_PASSWORD \
  --postrges=$POSTGRES_ETHDB \
  --postgres.hostname=$POSTGRES_HOST \
  --postgres.database=$POSTGRES_DATABASE
