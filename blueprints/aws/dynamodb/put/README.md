# DynamoDB Put Item

Support adding an item to a DynamoDB table from a JSON payload.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| data\_types | A map of column names with applicable DynamoDB data type | map | `<map>` | no |
| function\_name | A unique name used to reference the function | string | - | yes |
| lambda\_path | The root path to lambda function source | string | `lambda` | no |
| put\_item\_timeout | The maximum time (seconds) to allow the put job to execute | string | `30` | no |
| region | AWS default region | string | - | yes |
| table\_name | The name of the DynamoDB table to put items into | string | - | yes |

