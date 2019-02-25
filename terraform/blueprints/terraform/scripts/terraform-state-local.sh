#!/usr/bin/env bash
BLUEPRINT="$(basename $0 .sh)"

docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  bedrock/$BLUEPRINT