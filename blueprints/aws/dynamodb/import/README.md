# DynamoDB Batch Import

Support processing of data files of various formats (e.g. CSV) to populate a DynamoDB table.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| auto\_generate\_key | Indicates whether the import function should automatically generate a unique partition key | string | `true` | no |
| data\_types | A map of column names with applicable DynamoDB data type | map | `<map>` | no |
| function\_name | A unique name used to reference the function | string | - | yes |
| import\_timeout | The maximum time (seconds) to allow the import job to execute | string | `30` | no |
| item\_template | A template map used to initialise each item | map | `<map>` | no |
| lambda\_path | The root path to lambda function source | string | `lambda` | no |
| region | AWS default region | string | - | yes |
| table\_name | The name of the DynamoDB table to import into | string | - | yes |

