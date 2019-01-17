#!/usr/bin/env bash

# Initialise terraform provider, etc.
terraform init /bootstrap

terraform import -config=/bootstrap aws_s3_bucket.tf_state "$(aws sts get-caller-identity | jq -r '.Account')-terraform-state"

# Provision resources
terraform apply /bootstrap

# Generate terraform backend config
sh /bootstrap/backend_tf.sh > backend.tf && \
    sh /bootstrap/backend_tfvars.sh $TF_BACKEND_KEY > backend.tfvars
