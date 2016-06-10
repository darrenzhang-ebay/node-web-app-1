#!/bin/bash

set -o pipefail

IMAGE = dazhang/node-web-app-1
VERSION = 0.5

docker build -t ${IMAGE}:${VERSION} . | tee build.log || exit 1
ID=$(tail -1 build.log | awk '{print $3;}')

docker tag $ID ${IMAGE}:latest

docker images | grep ${IMAGE}

# docker run --rm ${IMAGE}:latest /opt/java7/bin/java -version