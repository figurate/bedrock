#!/usr/bin/env bash

# Generate terraform backend config
sh /bootstrap/backend_tf.sh > /bootstrap/backend.tf

if [ -n "$TF_STACK" ]; then
    sh /bootstrap/stack/backend_tfvars.sh $TF_STACK $TF_ENVIRONMENT > backend.tfvars
    sh /bootstrap/stack/terraform_tfvars.sh $TF_STACK > terraform.tfvars
elif [ -n "$TF_ENVIRONMENT" ]; then
    sh /bootstrap/environment/backend_tfvars.sh $TF_ENVIRONMENT > backend.tfvars
    sh /bootstrap/environment/terraform_tfvars.sh $TF_ENVIRONMENT > terraform.tfvars
else
    sh /bootstrap/backend_tfvars.sh $TF_BACKEND_KEY > backend.tfvars
fi

# Initialise terraform provider, etc.
terraform init -backend-config backend.tfvars $TF_INIT_ARGS /bootstrap

# Provision resources
terraform apply $TF_APPLY_ARGS /bootstrap

# Additional commands to run after terraform apply
/bootstrap/post-apply.sh $@
