#!/usr/bin/env bash

echo ">>> Installing RVM"

# Import Michal Papis' key to be able to verify the installation
echo ">>> Importing rvm public key"
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3

# Re-source RVM
. /home/vagrant/.rvm/scripts/rvm

# Re-source .profile if exists
if [[ -f "/home/vagrant/.profile" ]]; then
    . /home/vagrant/.profile
fi