#!/usr/bin/env bash

# NOTE: Script requires root privileges.

# 1. Installation instructions from: https://docs.docker.com/engine/installation/linux/debian/#/install-using-the-repository
apt-get install -y --no-install-recommends \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common

curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -

add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       debian-$(lsb_release -cs) \
       main"

apt-get update && apt-get -y install docker-engine

# 2. Post install instructions from: https://docs.docker.com/engine/installation/linux/linux-postinstall/

groupadd docker

# XXX: modify user as required..
#su debian -c usermod -aG docker $USER
usermod -aG docker debian

systemctl enable docker

# 3. Install docker-compose from here: https://github.com/docker/compose/releases
curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
