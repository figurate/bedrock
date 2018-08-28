#!/usr/bin/env bash

# Generate terraform backend config
sh /bootstrap/backend_tf.sh > /bootstrap/backend.tf && \
    sh /bootstrap/backend_tfvars.sh $TF_BACKEND_KEY > backend.tfvars

# Initialise terraform provider, etc.
terraform init -backend-config backend.tfvars -upgrade /bootstrap

# Provision resources
terraform apply $TF_APPLY_ARGS /bootstrap

# Additional commands to run after terraform apply
/bootstrap/post-apply.sh $@
