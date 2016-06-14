#!/usr/bin/env bash

set -o pipefail

echo "========================="
echo "Update the package information"
/usr/bin/apt-get update
/usr/bin/apt-get install apt-transport-https ca-certificates
# echo "Adding the new GPG key"
# sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "========================="
echo "Update the source entry"
cd /etc/apt/sources.list.d/
touch docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > docker.list

echo "========================="
echo "Install Docker"
/usr/bin/apt-get update /usr/bin/apt-get install docker-engine && service docker start

echo "========================="
echo "Create a docker group"
groupadd docker
usermod -aG docker sysadmin

