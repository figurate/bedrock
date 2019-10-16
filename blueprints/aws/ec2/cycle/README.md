# EC2 Instance Cycling

A Lambda function to support power cycling EC2 instances.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| lambda\_path | The root path to lambda function source | string | `lambda` | no |
| region | AWS default region | string | - | yes |

