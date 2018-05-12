#!/usr/bin/env bash
/opt/puppetlabs/bin/puppet apply --modulepath modules:site:thirdparty:$basemodulepath --hiera_config ./hieradata/hiera.yaml $@
