#!/bin/bash

set -o pipefail

IMAGE="dazhang/node-web-app-1"
VERSION="0.8"

echo ${VERSION}

echo "Start building"
docker build -t ${IMAGE}:${VERSION} . | sudo tee build.log || exit 1
echo "End building"

echo "Get the latest ID"
ID=$(tail -1 build.log | awk '{print $3;}')

echo "Tagging the latest"
docker tag $ID ${IMAGE}:latest


# docker images | grep ${IMAGE}
# docker run --rm ${IMAGE}:latest /opt/java7/bin/java -version