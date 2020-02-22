#!/bin/bash

# Uninstall previous versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# Update the apt package index:
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

# Use the following command to set up the stable repository:
#    here select the commands for "arm64"
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update the apt package index.
sudo apt-get update

# Install the latest version of Docker CE and containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose

# Add user to the group "docker", so we don't need sudo
sudo usermod -aG docker rob
# Now logout and login again

# install NVIDIA Container Toolkit support for docker, documented here...
# https://github.com/NVIDIA/nvidia-docker/blob/master/README.md#quickstart
#
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit

# update Docker so default container is nvidia
sudo cp ./daemon.json /etc/docker/
sudo systemctl restart docker

# now need to login to Nvidia docker repo, but need some extra steps as docker login doesn't work properly
# per https://github.com/docker/docker-credential-helpers/issues/105

sudo apt-get remove golang-docker-credential-helpers

# make sure to register with https://ngc.nvidia.com/ and generate an API key from the setup menu
# enter creds for Nvidio cloud when prompted
# username is $oauthtoken, and API key is the password.
docker login nvcr.io
sudo apt-get install docker-compose

