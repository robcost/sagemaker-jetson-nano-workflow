#!/bin/bash
mkdir /tmp/docker-build
cp ./Dockerfile /tmp/docker-build
cd /tmp/docker-build
cp -r /usr/local/cuda/samples/ ./
sudo docker build -t devicequery .
sudo docker run -it devicequery