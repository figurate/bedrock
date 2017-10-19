#!/usr/bin/env bash

if [[ $TAG =~ ^release- ]]; then
    git tag --force $TAG && git push $GIT_REPO :refs/tags/$TAG && git push $GIT_REPO refs/tags/$TAG
fi
