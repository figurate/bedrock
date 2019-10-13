# AWS IAM policies

Purpose: Provision IAM policies in AWS.

Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.

This script will create policies for common activities that may be attached to roles. Policies are grouped
according to the AWS services/APIs to which access is granted.

Typically IAM policies are a group of permissions that allows a particular activity, such as writing
logs to Cloudwatch, provisioning DynamoDB tables, etc.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | AWS default region | string | - | yes |

