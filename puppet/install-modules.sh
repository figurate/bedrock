#!/usr/bin/env bash
cd $(dirname $0)
r10k -t puppetfile install
