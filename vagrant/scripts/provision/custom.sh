#!/usr/bin/env bash
# This script will read the yaml configuration, and decide which extra things need to be installed 
# YAML parsing is taken from: (taken from: https://gist.github.com/pkuczynski/8665367)

# include parse_yaml function and parse our config file. Will be parsed with 'config_' prefix.
. /vagrant/vagrant/scripts/util/parse_yaml.sh
eval $(parse_yaml /vagrant/vagrant/config.yaml "config_")

# Elasticsearch
if [[ $config_elasticsearch == true ]] 
	then
		echo ">>> Installing Elasticsearch"
		sudo apt-get update && sh /vagrant/vagrant/scripts/provision/elasticsearch.sh
fi

# Mailcatcher
if [[ $config_mailcatcher == true ]] 
	then
		echo ">>> Installing Mailcatcher"
		sudo apt-get update && sh /vagrant/vagrant/scripts/provision/mailcatcher.sh
fi
