# hosting
Setup of hosting servers I manage. This document is still under development, use at your own risk!

## General

Use VPS's from Vultr.com, with SATA disks (SSD disks are often too small), 2Gb RAM, and latest Ubuntu installed.

Install  Docker and [io.js](https://iojs.org) (Node.js, but with bigger and faster version numbers):

````bash
# Install Docker:
curl -sSL https://get.docker.com/ | sh
servicectl enable docker # See https://github.com/docker/docker/issues/12002#issuecomment-106759295

# Install io.js:
wget https://iojs.org/dist/v2.1.0/iojs-v2.1.0-linux-x64.tar.xz
tar -xf ./iojs-v2.1.0-linux-x64.tar.xz
rsync -a iojs-v2.1.0-linux-x64/ /usr/local/
````

There seems to be a problem where the docker service does not start after reboot on Ubuntu 15.04.

Now, install [snickers-proxy](https://github.com/michielbdejong/snickers-proxy), configure the sites you want to host.

## Running snickers-proxy

To make sure a node process keeps running on the server after you log out and restart the server,
I recommend using a tool like pm2:

````bash
npm install -g pm2
sudo su
pm2 start snickers.js
pm2 startup systemd # See https://github.com/Unitech/PM2/issues/1319
pm2 list
````
## Configuring failover

For static sites, use DNS round-robin to host them on at least two servers.

For dynamic sites, point DNS to a master, and git push snapshots to a hot spare. The hot spare also functions as a backup server, and using git gives very good rollback options (daily backups are often not enough for effective firefighting).
