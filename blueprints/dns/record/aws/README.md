## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| fqdn | Fully-qualified domain name for the record | string | - | yes |
| record\_ttl | The time to live (TTL) in seconds | string | `900` | no |
| record\_type | Indicates the type of DNS record (A, CNAME, etc.) | string | `A` | no |
| region | AWS default region | string | - | yes |
| targets | A list of target values for the DNS record | list | - | yes |

