# AWS AWstats role configuration

Purpose: Provision IAM roles in AWS.

Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.

This script will create roles that has the following privileges:

* Access for managing AWstats hosts specific to this blueprint

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| region | AWS default region | string | - | yes |

