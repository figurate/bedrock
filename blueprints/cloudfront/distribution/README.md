## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_log\_bucket | An S3 bucket used as a target for access logs | string | `` | no |
| aliases | A list of associated domain names that reference the distribution | list | `<list>` | no |
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| bucket\_name | Name of target S3 bucket | string | - | yes |
| default\_root\_object | The default page when accessing the root URL of the distribution | string | `index.html` | no |
| default\_ttl | Default time-to-live (TTL) for objects in cache | string | `86400` | no |
| enabled | Indicates if distribution is enabled | string | `false` | no |
| error\_page | Error page returned for 404 errors | string | - | yes |
| hosted\_zone | Route53 zone for alias domain names | string | - | yes |
| price\_class | Specifies the edge locations based on price class | string | `PriceClass_100` | no |
| region | AWS default region | string | - | yes |

