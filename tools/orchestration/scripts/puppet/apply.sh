#!/usr/bin/env bash
/opt/bedrock/puppet/install-modules.sh && /opt/bedrock/puppet/puppet-apply.sh --debug manifests
