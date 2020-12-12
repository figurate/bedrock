## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudformation\_path | The root path to cloudformation templates | string | `cloudformation` | no |
| cluster\_name | Name of the ECS cluster | string | - | yes |
| hosted\_zone | A Route53 hosted zone to associate the ECS cluster endpoint | string | - | yes |
| region | AWS default region | string | - | yes |

