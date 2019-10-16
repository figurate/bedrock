# AWS IAM user configuration

Purpose: Provision an IAM user in AWS.

Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.

This script will create a user that has the following privileges:

* IAM access for creation of IAM roles specific to a blueprint
* Access to read/write Terraform state associated with the account
* Access to assume roles required to provision a blueprint

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_groups | A list of IAM groups the user belongs to. | list | `<list>` | no |
| region | AWS default region | string | - | yes |
| username | The username of the Bedrock power user | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_access\_key\_id | The AWS access key associated with the power user |
| aws\_secret\_access\_key | The AWS access key secret associated with the power user |
| poweruser\_name | The username of the provisioned power user |

