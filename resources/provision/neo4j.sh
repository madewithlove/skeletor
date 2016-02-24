#!/usr/bin/env bash

echo ">>> Installing Neo4J"

# Install prerequisite: Java
# -qq implies -y --force-yes
sudo apt-get update
sudo apt-get install -qq openjdk-7-jre-headless

# Add the Neo4J key into the apt package manager:
wget -O - https://debian.neo4j.org/neotechnology.gpg.key | apt-key add -

# Add Neo4J to the Apt sources list:
echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list

# Update the package manager:
apt-get update

# Install Neo4J:
apt-get install -qq neo4j

# Allow connection to admin from anywhere
echo 'org.neo4j.server.webserver.address=0.0.0.0' | sudo tee -a /etc/neo4j/neo4j-server.properties

# Start the server
service neo4j-service restart

# Change default password
curl -XPOST http://localhost:7474/user/neo4j/password -H "Authorization: Basic bmVvNGo6bmVvNGo=" -H "Content-Type: application/x-www-form-urlencoded" --data-urlencode "password=secret"
