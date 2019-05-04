# AWS reverse proxy configuration

Provision an NGINX reverse proxy for an environment.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| amplify\_key | API key for nginx amplify | string | - | yes |
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| cloudformation\_path | The root path to cloudformation templates | string | `cloudformation` | no |
| environment | The name of the environment associated with the reverse proxy | string | - | yes |
| image\_name | AWS image for autoscaling launch configuration | string | `amzn2-ami-hvm-*` | no |
| image\_os | The operating system installed on the selected AMI. Valid values are:<br><br>  * al2     = Amazon Linux 2   * ubuntu  = Ubuntu | string | `al2` | no |
| image\_owner | AMI image owner (leave blank for current account) | string | `137112412989` | no |
| instance\_type | AWS instance type for launch configuration | string | `t3.nano` | no |
| papertrail\_host | Target URL for Papertrail logs | string | - | yes |
| papertrail\_port | Target port for Papertrail logs | string | - | yes |
| region | AWS default region | string | - | yes |
| userdata\_path | The root path to userdata templates | string | `userdata` | no |

