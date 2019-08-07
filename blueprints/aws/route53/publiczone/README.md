## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apex\_redirect\_fqdn | The FQDN to redirect requests for the apex domain of the hosted zone | string | `` | no |
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| fqdn | A fully qualified domain name (FQDN) that is the basis for the hosted zone | string | - | yes |
| region | AWS default region | string | - | yes |
| source\_cidrs | Restrict S3 website access to the specified CIDR blocks of IP addresses | list | `<list>` | no |

