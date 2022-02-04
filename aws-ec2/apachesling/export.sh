#!/usr/bin/env bash

# Generate terraform backend config
sh /bootstrap/backend_tf.sh > /bootstrap/backend.tf

# export terraform files to current directory
cp /bootstrap/*.tf ./
cp -R /bootstrap/cloudformation ./
cp -R /bootstrap/templates ./
