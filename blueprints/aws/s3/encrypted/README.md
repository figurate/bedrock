# AWS S3 bucket configuration

Provision an S3 bucket in AWS.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_log\_bucket | An S3 bucket used as a target for access logs | string | - | yes |
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| bucket\_name | Name of S3 bucket | string | - | yes |
| content\_path | Root path of local content | string | `.` | no |
| delete | Remove files from the destination that don't exist in the source | string | `false` | no |
| excludes | A list of exclude filters to apply | list | `<list>` | no |
| includes | A list of include filters to apply | list | `<list>` | no |
| object\_expires | Number of days before object expiration | string | `0` | no |
| region | AWS default region | string | - | yes |
| version\_enabled | Enable object versioning | string | `true` | no |

