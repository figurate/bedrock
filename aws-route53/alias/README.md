## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| fqdn | Fully-qualified domain name for the record | string | - | yes |
| record\_type | Indicates the type of DNS record (A, CNAME, etc.) | string | `A` | no |
| region | AWS default region | string | - | yes |
| target | An alias target for the DNS record | string | - | yes |

