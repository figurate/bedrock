#!/usr/bin/env bash
docker build -t developer-env . && docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  developer-env