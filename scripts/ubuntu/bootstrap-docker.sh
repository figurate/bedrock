#!/usr/bin/env bash

TERRAFORM_VERSION="0.11.1"
PACKER_VERSION="1.1.3"
VAULT_VERSION="0.9.3"

GIT_USERNAME="Ben Fortuna"
GIT_EMAIL="fortuna@micronode.com"

# Install packages
apt-get update && apt-get install -y curl git python3-pip apt-transport-https \
 ca-certificates software-properties-common corkscrew unzip wget ssh jq ruby

# AWS CLI
pip3 install awscli --upgrade
mkdir .aws && touch .aws/credentials
echo '[default]
region = ap-southeast-2' > .aws/config

# Terraform
wget -P /tmp/install "https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
unzip "/tmp/install/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -d /usr/bin

# Packer
wget -P /tmp/install "https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_${PACKER_VERSION}_linux_amd64.zip"
unzip "/tmp/install/packer_${PACKER_VERSION}_linux_amd64.zip" -d /usr/bin

# Vault
wget -P /tmp/install "https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_${VAULT_VERSION}_linux_amd64.zip"
unzip "/tmp/install/vault_${VAULT_VERSION}_linux_amd64.zip" -d /usr/bin

# Puppet
wget -P /tmp/install https://apt.puppetlabs.com/puppet5-release-xenial.deb
dpkg -i /tmp/install/puppet5-release-xenial.deb
apt-get update && apt-get install -y puppet-agent
gem install r10k

# Git
echo "[credential]
        helper = !aws codecommit credential-helper $@
        UseHttpPath = true
[user]
        name = $GIT_USERNAME
        email = $GIT_EMAIL" >> .gitconfig
        
