# AWS Bastion host configuration

Provision an EC2 instance with SSH ingress authenticated with the specified public key.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_image | AWS image for bastion instance | string | `ami-00e17d1165b9dd3ec` | no |
| bastion\_user | Username for bastion SSH user | string | - | yes |
| enabled | Start/stop the bastion host | string | - | yes |
| instance\_type | AWS instance type for bastion | string | `t2.micro` | no |
| region | AWS default region | string | - | yes |
| ssh\_key | Location of public key file for SSH access to droplets | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ip | - |

