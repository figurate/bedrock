#!/usr/bin/env bash
docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  --volume "$HOME/.aws:/root/.aws" \
  --volume "$HOME/.ssh:/root/.ssh" \
  -e TF_BACKEND_KEY=${TF_BACKEND_KEY:-$(basename $PWD)} \
  -e TF_STACK=${TF_STACK} \
  -e TF_ENVIRONMENT=${TF_ENVIRONMENT} \
  -e TF_ENV_SUFFIX=${TF_ENV_SUFFIX} \
  bedrock/swapfile-linux $@
