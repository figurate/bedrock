#!/usr/bin/env bash
docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  --volume "$HOME/.aws:/root/.aws" \
  --volume "$HOME/.ssh:/root/.ssh" \
  -e TF_BACKEND_KEY=${TF_BACKEND_KEY:-$(basename $PWD)} \
  -e TF_APPLY_ARGS=${TF_APPLY_ARGS} \
  -e http_proxy=${http_proxy:-} \
  -e https_proxy=${https_proxy:-} \
  -e no_proxy=${no_proxy:-} \
  --net=host \
  bedrock/bastion:aws $@