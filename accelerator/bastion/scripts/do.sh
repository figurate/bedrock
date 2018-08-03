#!/usr/bin/env bash
docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  --volume "$HOME/.aws:/root/.aws" \
  --volume "$HOME/.ssh:/root/.ssh" \
  -e TF_BACKEND_KEY=${TF_BACKEND_KEY:-$(basename $PWD)} \
  bedrock/bastion:do