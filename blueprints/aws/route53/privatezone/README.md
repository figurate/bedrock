## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| fqdn | A fully qualified domain name (FQDN) that is the basis for the hosted zone | string | - | yes |
| region | AWS default region | string | - | yes |
| vpc\_id | Identifier of VPC to associated private zone with (leave blank to indicate default VPC) | string | `` | no |

