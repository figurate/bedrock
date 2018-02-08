#!/usr/bin/env bash

TERRAFORM_VERSION="0.11.1"
PACKER_VERSION="1.1.3"
GIT_USERNAME="Ben Fortuna"
GIT_EMAIL="fortuna@micronode.com"

# NTP
echo 'daemon $binary "--timesync-set-start --timesync-set-on-restore 1 --timesync-set-threshold 5000" > /dev/null
start-stop-daemon --start --nicelevel "-5" --exec $1 -- $2' | sudo tee /etc/init.d/vboxadd-service

# Install packages
sudo apt-get update && sudo apt-get install -y curl git python3-pip apt-transport-https \
  ca-certificates software-properties-common corkscrew unzip

# AWS CLI
pip3 install awscli --upgrade
mkdir .aws && touch .aws/credentials
echo '[default]
region = ap-southeast-2' >> .aws/config
chown -R vagrant:vagrant .aws/

# Docker

# Terraform

# Packer

# Puppet

# Git
