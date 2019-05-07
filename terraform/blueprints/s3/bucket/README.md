# AWS S3 bucket configuration

Provision an S3 bucket in AWS.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| bucket\_acl | Access control for bucket | string | `private` | no |
| bucket\_name | Name of S3 bucket | string | - | yes |
| object\_expires | Number of days before object expiration | string | `0` | no |
| region | AWS default region | string | - | yes |
| version\_enabled | Enable object versioning | string | `true` | no |

