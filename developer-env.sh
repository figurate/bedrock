#!/usr/bin/env bash
docker run -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  developer-env