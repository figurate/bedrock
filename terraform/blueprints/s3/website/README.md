# AWS S3 website configuration

Provision a static website using an S3 bucket in AWS.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_log\_bucket | An S3 bucket used as a target for access logs | string | `` | no |
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| content\_path | Root path of local website content | string | `.` | no |
| create\_route53\_record | Boolean value to indicate whether route53 record is created | string | `true` | no |
| delete | Remove files from the destination that don't exist in the source | string | `false` | no |
| error\_page | HTML error page | string | `error.html` | no |
| excludes | A list of exclude filters to apply | list | `<list>` | no |
| fqdn | Website domain | string | - | yes |
| includes | A list of include filters to apply | list | `<list>` | no |
| index\_page | HTML index page | string | `index.html` | no |
| object\_expiration | Configure expiry of old verions (days) | string | `90` | no |
| region | AWS default region | string | - | yes |
| routing\_rules | - | string | `` | no |
| source\_cidrs | Restrict site access to the specified CIDR blocks of IP addresses | list | `<list>` | no |
| version\_enabled | Enable object versioning | string | `true` | no |

