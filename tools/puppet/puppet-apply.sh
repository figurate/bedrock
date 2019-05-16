#!/usr/bin/env bash
cd $(dirname $0)
/opt/puppetlabs/bin/puppet apply --modulepath modules:site:thirdparty:$basemodulepath --hiera_config ./hieradata/hiera.yaml $@
