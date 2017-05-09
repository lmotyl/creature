#!/usr/bin/env bash

NODE_VERSION=6.x
USERNAME=ubuntu

apt-get update
apt-get install -y nginx
# set up nginx server
sudo cp /vagrant/.provision/nginx/nginx.conf /etc/nginx/sites-available/site.conf
sudo cp -f /vagrant/.provision/etc/hosts /etc/hosts
sudo chmod 644 /etc/nginx/sites-available/site.conf
sudo ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
sudo service nginx restart
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
curl -sL https://deb.nodesource.com/setup_$NODE_VERSION | sudo -E bash -
apt-get install -y nodejs
apt-get install -y build-essential
npm install -g pm2

# at first starup you could need go to vagrant and write: pm2 start server.js
env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u $USERNAME --hp /home/$USERNAME