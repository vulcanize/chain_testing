# Build Geth in a stock Go builder container
FROM golang:1.14-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

ARG GETH_REPO_URL=https://github.com/ethereum/go-ethereum.git
ARG GETH_BRANCH_NAME=master

WORKDIR src/
RUN git clone ${GETH_REPO_URL} .
RUN git checkout ${GETH_BRANCH_NAME}
RUN git pull
RUN make geth

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest
WORKDIR .

RUN apk add --no-cache ca-certificates
COPY --from=builder go/src/build/bin/geth /usr/local/bin/

EXPOSE 8545 8546 8547 30303 30303/udp

COPY startup_script.sh /bin/startup_script.sh
RUN chmod +x /bin/startup_script.sh

ENTRYPOINT ["sh", "/bin/startup_script.sh"]