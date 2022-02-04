## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| bucket\_name | The name of the S3 bucket to import into | string | - | yes |
| function\_name | A unique name used to reference the function | string | - | yes |
| import\_timeout | The maximum time (seconds) to allow the import job to execute | string | `30` | no |
| lambda\_path | The root path to lambda function source | string | `lambda` | no |
| region | AWS default region | string | - | yes |

