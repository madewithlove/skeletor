#!/usr/bin/env bash
# Based on Vaprobash: https://github.com/fideloper/Vaprobash/blob/master/scripts/mailcatcher.sh

echo ">>> Installing Mailcatcher"

# Installing dependency
# -qq implies -y --force-yes
sudo apt-get install -qq libsqlite3-dev ruby1.9.1-dev

# We use RVM so install with that
echo ">>>>Installing with RVM"
$(which rvm) default@mailcatcher --create do gem install --no-rdoc --no-ri mailcatcher
$(which rvm) wrapper default@mailcatcher --no-prefix mailcatcher catchmail


# Make it start on boot
sudo tee /etc/init/mailcatcher.conf <<EOL
description "Mailcatcher"

start on runlevel [2345]
stop on runlevel [!2345]

respawn

exec /usr/bin/env $(which mailcatcher) --foreground --http-ip=0.0.0.0
EOL

# Start Mailcatcher
sudo service mailcatcher start

# Make php use it to send mail
echo "sendmail_path = /usr/bin/env $(which catchmail)" | sudo tee /etc/php5/mods-available/mailcatcher.ini
sudo php5enmod mailcatcher
sudo service php5-fpm restart
