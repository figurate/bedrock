# AWS Lambda function configuration

Deploy a lambda function.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| bucket\_name | Name of the target S3 bucket | string | - | yes |
| function\_name | A unique name used to reference the function | string | - | yes |
| lambda\_path | The root path to lambda function source | string | `lambda` | no |
| region | AWS default region | string | - | yes |

