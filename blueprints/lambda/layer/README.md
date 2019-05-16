## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| content\_path | Path to content to include in the layer | string | - | yes |
| description | A short description of the layer contents | string | - | yes |
| layer\_name | Name of the lambda layer | string | - | yes |
| region | AWS default region | string | - | yes |
| runtimes | List of compatible runtimes for the lambda layer | list | - | yes |

