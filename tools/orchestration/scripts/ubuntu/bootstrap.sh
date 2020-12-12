#!/usr/bin/env bash

USER="vagrant"
TERRAFORM_VERSION="0.11.1"
PACKER_VERSION="1.1.3"
VAULT_VERSION="0.9.3"
GIT_USERNAME="Ben Fortuna"
GIT_EMAIL="fortuna@micronode.com"

# NTP
echo 'daemon $binary "--timesync-set-start --timesync-set-on-restore 1 --timesync-set-threshold 5000" > /dev/null
start-stop-daemon --start --nicelevel "-5" --exec $1 -- $2' | sudo tee /etc/init.d/vboxadd-service

# Install packages
sudo apt-get update && sudo apt-get install -y curl git python3-pip apt-transport-https \
  ca-certificates software-properties-common corkscrew unzip jq ruby

# AWS CLI
pip3 install awscli --upgrade
mkdir .aws && touch .aws/credentials
echo '[default]
region = ap-southeast-2' > .aws/config
chown -R $USER:$USER .aws/

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && sudo apt-get install -y docker-ce
echo '{
      "debug" : true,
      "experimental" : true
}' | sudo tee /etc/docker/daemon.json
sudo usermod -a -G docker $USER
sudo systemctl daemon-reload && sudo service docker restart

# Terraform
wget -P /tmp/install "https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
sudo unzip "/tmp/install/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -d /usr/bin

# Packer
wget -P /tmp/install "https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_${PACKER_VERSION}_linux_amd64.zip"
sudo unzip "/tmp/install/packer_${PACKER_VERSION}_linux_amd64.zip" -d /usr/bin

# Vault
wget -P /tmp/install "https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_${VAULT_VERSION}_linux_amd64.zip"
sudo unzip "/tmp/install/vault_${VAULT_VERSION}_linux_amd64.zip" -d /usr/bin

# Puppet
wget -P /tmp/install https://apt.puppetlabs.com/puppet5-release-xenial.deb
sudo dpkg -i /tmp/install/puppet5-release-xenial.deb
sudo apt-get update && sudo apt-get install -y puppet-agent
sudo gem install r10k

# Git
echo "[credential]
        helper = !aws codecommit credential-helper $@
        UseHttpPath = true
[user]
        name = $GIT_USERNAME
        email = $GIT_EMAIL" >> .gitconfig
        
