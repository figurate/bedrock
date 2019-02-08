#!/usr/bin/env bash
docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  bedrock/terraform-state-local