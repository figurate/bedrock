#!/usr/bin/env bash
BEDROCK_BLUEPRINT="$(basename $0 .sh)"

. $(dirname $0)/../bin/blueprint-run.sh $@
