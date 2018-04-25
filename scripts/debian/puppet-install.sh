#!/usr/bin/env bash
wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
sudo dpkg -i puppet5-release-xenial.deb
sudo apt update
sudo apt install -y puppet-agent r10k
#export PATH=/opt/puppetlabs/bin:$PATH >> /etc/environment
