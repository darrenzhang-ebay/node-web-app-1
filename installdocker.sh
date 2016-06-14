#!usr/bin/env bash

set -o pipefail

echo "=================================="
echo "Update the package information..."
echo "=================================="
apt-get update
apt-get install apt-transport-https ca-certificates <<-EOF
yes
EOF

echo "=================================="
echo "Adding public key..."
echo "=================================="
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "=================================="
echo "Update the source entry..."
echo "=================================="
cd /etc/apt/sources.list.d/
rm docker.list <<-EOA
yes
EOA
touch docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >docker.list
apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine

echo "=================================="
echo "install docker..."
echo "=================================="
apt-get update
apt-get install linux-image-extra-$(uname -r)
apt-get install docker-engine <<-EOB
yes
EOB
service docker start

echo "=================================="
echo "create docker group and add sysadmin to the group..."
echo "=================================="
groupadd docker
usermod -aG docker sysadmin
