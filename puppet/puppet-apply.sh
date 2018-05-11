#!/usr/bin/env bash
/opt/puppetlabs/bin/puppet apply --modulepath modules:thirdparty --hiera_config ./hieradata/hiera.yaml $@
