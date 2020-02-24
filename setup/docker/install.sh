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

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit nvidia-container-runtime

sudo systemctl restart docker

# build scripts require python3 version of latest docker module
sudo apt install python3-pip
sudo pip3 install docker

# For using NVCR MXnet image, which doesn't seem to work on aarch64 currently
# make sure to register with https://ngc.nvidia.com/ and generate an API key from the setup menu
# enter creds for Nvidio cloud when prompted
# username is $oauthtoken, and API key is the password.
# docker login nvcr.io
# docker pull nvcr.io/nvidia/mxnet:20.01-py3
# docker run --gpus all -it --rm -v /home:/home nvcr.io/nvidia/mxnet:20.01-py3

# Build MXNet container from source
git clone --recursive https://github.com/apache/incubator-mxnet.git mxnet
export PATH=/usr/local/cuda/bin:$PATH
export MXNET_HOME=$HOME/mxnet/
export PYTHONPATH=$MXNET_HOME/python:$PYTHONPATH
$MXNET_HOME/ci/build.py -p jetson



# Install MXNet from nvidia whl file
sudo pip3 install cython
# https://devtalk.nvidia.com/default/topic/1070767/jetson-nano/i-was-unable-to-compile-and-install-mxnet1-5-with-tensorrt-on-the-jetson-nano-is-there-someone-have-compile-it-please-help-me-thank-you-/post/5426042/#5426042
# download whl from https://drive.google.com/open?id=1acFgoFaw9arP1I6VZFR3Jjsm6TNkpR0v
curl https://s3.us-east-2.amazonaws.com/mxnet-public/install/jetson/1.4.0/mxnet-1.4.0-cp36-cp36m-linux_aarch64.whl --output mxnet-1.4.0-cp36-cp36m-linux_aarch64.whl
#sudo pip3 install mxnet-1.6.0-py3-none-any.whl
sudo apt-get install libatlas-base-dev
sudo pip3 install mxnet-1.4.0-cp36-cp36m-linux_aarch64.whl

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH


