# Digital Ocean Bastion host configuration

Provision a droplet with SSH ingress authenticated with the specified public key.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_image | Digital Ocean image for bastion droplet | string | `ubuntu-18-04-x64` | no |
| do\_region | Digital Ocean region | string | - | yes |
| do\_token | Digital Ocean API token | string | - | yes |
| enabled | Start/stop the bastion host | string | - | yes |
| ssh\_key | Identifier of public key file for SSH access to droplets | string | - | yes |
| ssh\_private\_key | Location of private key file for SSH access to droplets | string | `~/.ssh/id_rsa` | no |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_ip | IP address for bastion droplet |
| enabled | Start/stop the bastion host |
| monthly\_cost | Monthly cost for bastion droplet |
| ssh\_key | Name of key for SSH access to droplets |

