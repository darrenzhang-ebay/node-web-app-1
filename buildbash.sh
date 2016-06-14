#!/usr/bin/env bash
#~/.bush_alias
set -o pipefail

IMAGE="dazhang/node-web-app-1"
VERSION="0.8.1.9"

echo ${VERSION}
echo

echo "==================="
echo "Killing all running containers..."
docker kill -f $(docker ps -q)

echo "Deleting all stopped containers..."
docker rm -f $(docker ps -a -q)

echo "Deleting all untagged images..."
docker rmi -f $(docker images -q -f "dangling=true")

echo "Deleting all old images..."
docker rmi -f $(docker images -q)

echo "====================="

echo "Start building image"
docker build -t ${IMAGE}:${VERSION} . | sudo tee build.log || exit 1
echo "End building image"

echo "Get the latest ID"
ID=$(tail -1 build.log | awk '{print $3;}')

echo "Tagging the latest"
docker tag $ID ${IMAGE}:latest

echo "pushing the latest to hub"
docker push ${IMAGE}:${VERSION}

echo "End"

# docker images | grep ${IMAGE}
# docker run --rm ${IMAGE}:latest /opt/java7/bin/java -version