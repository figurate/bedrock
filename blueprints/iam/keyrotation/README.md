# IAM Access Key Rotation Management

Support for automatic disabling/deletion of old API access keys.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| key\_max\_age | The maximum age (in days) of an IAM access key before it is disabled. | string | `90` | no |
| lambda\_path | The root path to lambda function source | string | `lambda` | no |
| lambda\_timeout | Maximum time (seconds) to allow the lambda to execute | string | `15` | no |
| region | AWS default region | string | - | yes |

