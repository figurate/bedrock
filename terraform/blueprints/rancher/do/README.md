## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_host | Bastion host used to access reverse proxy | string | - | yes |
| do\_region | Digital Ocean region | string | - | yes |
| do\_token | Digital Ocean API token | string | - | yes |
| enabled | Start/stop the rancher server host | string | - | yes |
| environment | Environment identifier for the rancher hosts | string | - | yes |
| hostname | Hostname to configure in virtual host | string | `rancher.mnode.org` | no |
| rancher\_image | Digital Ocean image for rancher server droplet | string | `ubuntu-18-04-x64` | no |
| reverseproxy\_host | Host to install vhost configuration | string | - | yes |
| ssh\_key | Identifier of public key file for SSH access to droplets | string | - | yes |
| ssh\_private\_key | Location of private key file for SSH access to droplets | string | `~/.ssh/id_rsa` | no |

## Outputs

| Name | Description |
|------|-------------|
| do\_region | Digital Ocean region |
| do\_token | Digital Ocean API token |
| enabled | Start/stop the rancher host |
| rancherserver\_ip | - |
| ssh\_key | Location of public key file for SSH access to droplets |

