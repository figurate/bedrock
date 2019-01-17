#!/usr/bin/env bash

# Generate terraform backend config
sh /bootstrap/backend_tf.sh > backend.tf && \
    sh /bootstrap/backend_tfvars.sh > backend.tfvars
