#!/bin/bash


POSTGRES_CLONE_URL=${POSTGRES_CLONE_URL:-"https://github.com/vulcanize/optimism-monorepo.git"}
POSTGRES_BRANCH_NAME=${POSTGRES_BRANCH_NAME:-"master"}
POSTGRES_BUILD_PATH=${POSTGRES_BUILD_PATH:-"db"}
POSTGRES_NAME=${POSTGRES_NAME:-"eth-optimism/postgres"}
POSTGRES_TAG=${POSTGRES_TAG:-"master"}
POSTGRES_VOLUME_HOST_PATH=${POSTGRES_VOLUME_HOST_PATH:-"chain_testing_postgres"}
POSTGRES_VOLUME_DST_PATH=${POSTGRES_VOLUME_DST_PATH:-"/var/lib/postgresql/data"}
POSTGRES_SERVICE_NAME=${POSTGRES_SERVICE_NAME:-"postgres"}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-"password"}

mkdir -p tmp/
cd tmp/
git clone "$POSTGRES_CLONE_URL" .
git checkout "$POSTGRES_BRANCH_NAME"
git pull
cd "$POSTGRES_BUILD_PATH"
echo "Building $POSTGRES_NAME:$POSTGRES_TAG"
docker build -t "$POSTGRES_NAME:$POSTGRES_TAG" .
cd ../../
rm -rf tmp/

echo "Starting $POSTGRES_NAME:$POSTGRES_TAG"

docker run --rm \
    -p 5432:5432 \
    -v "$POSTGRES_VOLUME_HOST_PATH:$POSTGRES_VOLUME_DST_PATH" \
    --name "$POSTGRES_SERVICE_NAME" \
    -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
    "$POSTGRES_NAME:$POSTGRES_TAG" &

docker-compose up