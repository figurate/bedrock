# ECR Repository Creation

Create an ECR repository with lifecycle rules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| image\_expiry | Number of days before untagged images expire | string | `7` | no |
| region | AWS default region | string | - | yes |
| repository\_name | Name of the Docker repository (image) | string | - | yes |

