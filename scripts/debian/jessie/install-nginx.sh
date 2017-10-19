#!/usr/bin/env bash

# 1. Installation instructions based on: https://github.com/nginxinc/NGINX-Demos/blob/master/packer-terraform-all-active-nginx-plus-lb/packer/scripts/install-nginx-oss.sh

sudo apt-get update && sudo apt-get -y upgrade
#sudo wget http://nginx.org/keys/nginx_signing.key
#sudo apt-key add nginx_signing.key
#sudo sed -i "$ a\deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx\ndeb-src http://nginx.org/packages/mainline/ubuntu/ xenial nginx" /etc/apt/sources.list
#sudo apt-get remove -y nginx-common
#sudo apt-get update
sudo apt-get install -y nginx
#sudo service nginx start

# Install Amplify agent
curl -L -O https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh
#cat > conf.d/stub_status.conf
