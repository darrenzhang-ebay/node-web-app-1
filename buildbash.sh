#!/bin/bash

set -o pipefail

IMAGE="dazhang/node-web-app-1"
VERSION="0.8.1.4"

echo ${VERSION}
echo

echo "======================================================"
echo "Killing all running containers..."
alias dockerkillall='docker kill $(docker ps -q)'

echo "Deleting all stopped containers..."
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

echo "Deleting all untagged images..."
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f "dangling=true")'

echo "Deleting all stopped containers and untagged images..."
alias dockerclean='dockercleanc || true && dockercleani'

echo "Deleting all old images..."
alias dockercleanall='docker rmi $(docker images -q)'

echo "======================================================"
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