#!/usr/bin/env bash

echo ">>> Installing RVM"

# Import Michal Papis' key to be able to verify the installation
echo ">>> Importing rvm public key"
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3

# Install RVM
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# Source RVM to activate it
. /usr/local/rvm/scripts/rvm

# Re-source .profile
. /home/vagrant/.profile

# Add vagrant user to rvm group
echo ">>> Adding vagrant user to the RVM group to prevent permission issues"
sudo usermod -a -G rvm vagrant