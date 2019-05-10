# Digital Ocean Bastion host configuration

Provision a droplet with SSH ingress authenticated with the specified public key.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_image | Digital Ocean image for bastion droplet | string | `ubuntu-18-04-x64` | no |
| bastion\_user | Username for bastion SSH user | string | - | yes |
| do\_region | Digital Ocean region | string | - | yes |
| do\_token | Digital Ocean API token | string | - | yes |
| enabled | Start/stop the bastion host | string | - | yes |
| image\_os | The operating system installed on the selected droplet. Valid values are:<br><br>  * ubuntu  = Ubuntu | string | `ubuntu` | no |
| shutdown\_delay | Number of minutes before the host will automatically shutdown | string | `60` | no |
| ssh\_key | Identifier of public key file for SSH access to droplets | string | - | yes |
| ssh\_private\_key | Location of private key file for SSH access to droplets | string | `~/.ssh/id_rsa` | no |
| userdata\_path | The root path to userdata templates | string | `userdata` | no |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_ip | IP address for bastion droplet |
| enabled | Start/stop the bastion host |
| monthly\_cost | Monthly cost for bastion droplet |
| ssh\_key | Name of key for SSH access to droplets |

