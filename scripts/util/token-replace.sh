#!/usr/bin/env bash
set -e

TOKEN=$1
VALUE=$2
TARGET=$3

perl -p -i -e "s#$TOKEN#$VALUE#g" $TARGET
