# AWS Bastion host configuration

Provision an EC2 instance with SSH ingress authenticated with the specified public key.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| bastion\_user | Username for bastion SSH user | string | - | yes |
| enabled | Start/stop the bastion host | string | `true` | no |
| image\_name | AWS image for bastion instance | string | `amzn2-ami-hvm-*` | no |
| image\_os | The operating system installed on the selected AMI. Valid values are:<br><br>  * al2     = Amazon Linux 2   * ubuntu  = Ubuntu | string | `al2` | no |
| image\_owner | AMI image owner (leave blank for current account) | string | `137112412989` | no |
| instance\_type | AWS instance type for bastion | string | `t3.nano` | no |
| region | AWS default region | string | - | yes |
| shutdown\_delay | Number of minutes before the host will automatically shutdown | string | `60` | no |
| ssh\_key | Location of public key file for SSH access to droplets | string | `~/.ssh/id_rsa.pub` | no |
| userdata\_path | The root path to userdata templates | string | `userdata` | no |

## Outputs

| Name | Description |
|------|-------------|
| ami\_id | - |
| instance\_ip | - |

