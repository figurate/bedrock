#!/usr/bin/env bash
#BEDROCK_BLUEPRINT="$(basename $0 .sh)"
BEDROCK_BLUEPRINT="s3-website"

. $(dirname $0)/../../../scripts/blueprint-run.sh $@
