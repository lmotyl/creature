#!/usr/bin/env bash

NODE_VERSION=6.x

apt-get update
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
curl -sL https://deb.nodesource.com/setup_$NODE_VERSION | sudo -E bash -
apt-get install -y nodejs
apt-get install -y build-essential