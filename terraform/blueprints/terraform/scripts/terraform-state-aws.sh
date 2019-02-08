#!/usr/bin/env bash
docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  --volume "$HOME/.aws:/root/.aws" \
  -e TF_BACKEND_KEY=$(basename $PWD) \
  bedrock/terraform-state-aws