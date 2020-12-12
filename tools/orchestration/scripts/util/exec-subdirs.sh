#!/usr/bin/env bash
# execute command in subdirectories: e.g. $ exec-subdirs.sh './gradlew clean'

COMMAND=$1
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && $COMMAND" \;

