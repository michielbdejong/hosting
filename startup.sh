#!/bin/bash

echo This startup script is for Ubuntu Wily 15.10


## General setup

apt-get update
apt-get upgrade
apt-get install unattended-upgrades git vim python


## Docker

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo deb https://apt.dockerproject.org/repo ubuntu-wily main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker*
apt-get install linux-image-extra-$(uname -r) docker-engine
service docker start


## Node.js

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
source /root/.bashrc
nvm install 4
npm install -g pm2


## Snickers

git clone https://github.com/michielbdejong/snickers
cd snickers
cp example/config.json .
cp -r example/snitch /etc
mkdir -p /data/domains
npm install
nvm exec 4 pm2 start snickers.js

echo In your local /etc/hosts file, please point your personal domain name to `ifconfig eth0 | grep inet\ addr | awk '{ print $2 }'`
