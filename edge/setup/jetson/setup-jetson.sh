#!/bin/bash

# install prerequisites
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y tmux htop

# setup book from USB drive using the jetsonhacks.com scripts
mkdir code
cd code
git clone https://github.com/JetsonHacksNano/rootOnUSB
cd rootOnUSB
./addUSBToInitramfs.sh
# make sure you have setup the USB drive per the instructions here before continuing...
# https://www.jetsonhacks.com/2019/09/17/jetson-nano-run-from-usb-drive/
./copyRootToUSB.sh -p /dev/sda1
./diskUUID.sh
# reboot

# create swap space
sudo fallocate -l 8G swapfile
sudo chmod 600 swapfile
sudo mkswap swapfile
sudo swapon swapfile

