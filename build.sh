#!/bin/bash
set -ex
cd "$(dirname "$0")"

VERSION=20191104

docker build . -t hadoop:${VERSION}
docker tag hadoop:${VERSION} hadoop:latest
docker tag hadoop:${VERSION} koichiroiijima/hadoop:${VERSION}
docker tag hadoop:${VERSION} koichiroiijima/hadoop:latest

docker push koichiroiijima/hadoop:${VERSION}
docker push koichiroiijima/hadoop:latest
