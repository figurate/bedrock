#!/usr/bin/env bash
#BEDROCK_BLUEPRINT="$(basename $0 .sh)"
BEDROCK_BLUEPRINT="bastion-do"

. $(dirname $0)/../../../scripts/blueprint-run.sh $@
