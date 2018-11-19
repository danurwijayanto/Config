#!/usr/bin/env bash
# Fail immediately if any of the commands below fail
#set -xe
set -x

mkdir -p bin
git config --global url."git@github.com:".insteadOf "https://github.com/"

# install glide
export GOBIN=/var/app/staging/bin
export GOPATH=/var/app/staging
export PATH=$PATH:$GOBIN:$GOPATH
curl https://glide.sh/get | sh
glide cc

mkdir -p /root/.ssh

wget -O /root/.ssh/id_rsa {{Path}}
wget -O /root/.ssh/id_rsa.pub {{Path}}
wget -O /root/.ssh/known_hosts {{Path}}
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub
chmod 644 /root/.ssh/known_hosts

# run glide up
cd src/github.com/AccelaryID/accelary-api-go/
wget -O env.json {{Path}}
./glide_mirror.sh
glide up

cd $GOPATH/src/github.com/AccelaryID/accelary-api-core/
wget -O dbconfig.yml {{Path}}

cd $GOPATH
wget -O env.json {{Path}}
wget -O dbconfig.yml {{Path}}

# build command
cp env.json bin/env.json

go build -o bin/application src/github.com/AccelaryID/accelary-api-go/application.go