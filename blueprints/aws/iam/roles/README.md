# AWS IAM role configuration

Purpose: Provision IAM roles in AWS.

Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.

This script will create a role that has the following privileges:

* IAM access for creation of IAM roles specific to this blueprint
* Access to read/write Terraform state associated with the account

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| mfa\_required | Indicates whether users assuming this role must have MFA enabled | string | `true` | no |
| region | AWS default region | string | - | yes |

