#!/bin/bash

cd /root &&
if ! which curl >> /dev/null; then
  apt-get install curl
fi;
if ! which docker >> /dev/null; then
  curl -fsSL get.docker.com -o /tmp/get-docker.sh
  sh /tmp/get-docker.sh
fi;

mkdir -p /root/.sentinel && \
mv config.data /root/.sentinel
docker rm $( docker stop $( docker ps -a -q --filter ancestor=sentinelofficial/sentinel-vpn-node:latest))
docker pull sentinelofficial/sentinel-vpn-node:latest
docker run -d --privileged --mount type=bind,source=/root/.sentinel,target=/root/.sentinel -p 3000:3000 -p 1194:1194/udp sentinelofficial/sentinel-vpn-node:latest
