#!/usr/bin/env bash

set -e

cd $(dirname $0)/client
GOOS=linux go build

cd $(dirname $0)
docker-compose stop || true
docker-compose rm -f || true
docker-compose up -d
