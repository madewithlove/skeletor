#!/usr/bin/env bash
sudo apt-get remove nodejs

# Install NVM and resource user profiles
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y build-essential
sudo apt-get install -y nodejs
sudo npm update -g
