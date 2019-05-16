#!/usr/bin/env bash

git branch release/$RELEASE_NAME && git push $GIT_REPO release/$RELEASE_NAME
