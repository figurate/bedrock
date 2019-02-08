# AWS Bastion host configuration

Provision an EC2 instance with SSH ingress authenticated with the specified public key.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_user | Username for bastion SSH user | string | - | yes |
| enabled | Start/stop the bastion host | string | - | yes |
| image\_name | AWS image for bastion instance | string | `amzn2-ami-hvm-*` | no |
| image\_owner | AMI image owner (leave blank for current account) | string | `137112412989` | no |
| instance\_type | AWS instance type for bastion | string | `t2.micro` | no |
| region | AWS default region | string | - | yes |
| ssh\_key | Location of public key file for SSH access to droplets | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| ami\_id | - |
| instance\_ip | - |

