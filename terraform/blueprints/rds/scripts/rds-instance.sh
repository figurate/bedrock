#!/usr/bin/env bash
BEDROCK_BLUEPRINT="$(basename $0 .sh)"

. $(dirname $0)/../../../scripts/blueprint-run.sh $@
