#!/usr/bin/env bash
wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
sudo dpkg -i puppet5-release-xenial.deb
sudo apt-get update
sudo apt-get install -y puppet-agent r10k hiera-eyaml
#export PATH=/opt/puppetlabs/bin:$PATH >> /etc/environment
