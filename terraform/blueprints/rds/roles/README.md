# AWS RDS role configuration

Purpose: Provision IAM roles in AWS.

Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.

This script will create a role that has the following privileges:

* Access for managing RDS clusters and instances specific to this blueprint
* Access to read/write Terraform state associated with the account

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| mfa\_required | Indicates whether users assuming this role must have MFA enabled | string | `true` | no |
| region | AWS default region | string | - | yes |

