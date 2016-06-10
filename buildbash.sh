#!/bin/bash

set -o pipefail

echo "Clearing old images..."
docker rmi $(docker images -q -f dangling=true)
docker rm -f(docker ps -a -q)
docker r

IMAGE="dazhang/node-web-app-1"
VERSION="0.8.1.1"

echo ${VERSION}

echo "Clearing old images..."
docker rmi $(docker images -q -f dangling=true)
docker rm -f $(docker ps -a -q)
docker rmi $(docker images -q | grep ${IMAGE})

echo "Start building"
docker build -t ${IMAGE}:${VERSION} . | sudo tee build.log || exit 1
echo "End building"

echo "Get the latest ID"
ID=$(tail -1 build.log | awk '{print $3;}')

echo "Tagging the latest"
docker tag $ID ${IMAGE}:latest

echo "pushing the latest to hub"
docker push ${IMAGE}:${VERSION}

echo "End"

# docker images | grep ${IMAGE}
# docker run --rm ${IMAGE}:latest /opt/java7/bin/java -version