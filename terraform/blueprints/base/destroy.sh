#!/usr/bin/env bash

# Generate terraform backend config
sh /bootstrap/backend_tf.sh > /bootstrap/backend.tf

# Initialise terraform provider, etc.
terraform init -backend-config backend.tfvars $TF_INIT_ARGS /bootstrap

# Remove resources
terraform destroy $TF_DESTROY_ARGS /bootstrap
