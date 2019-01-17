# NGINX vhost configuration

Configure a vhost on an existing NGINX installation.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_host | Bastion host used to access reverse proxy | string | - | yes |
| catalog\_id | ID of predefined stack in Rancher catalog | string | `` | no |
| docker\_compose | Location of docker-compose file | string | `` | no |
| enabled | Start/stop the rancher stack | string | - | yes |
| environment | Environment identifier for the rancher hosts | string | - | yes |
| error\_bg\_image | Path to background image used for error pages | string | - | yes |
| hostnames | Hostname to configure in virtual host | list | `<list>` | no |
| rancher\_access\_key | Rancher API access key | string | - | yes |
| rancher\_compose | Location of rancher-compose file | string | `` | no |
| rancher\_secret\_key | Rancher API secret key | string | - | yes |
| rancher\_url | Base URL of Rancher API | string | `http://rancher.mnode.org` | no |
| reverseproxy\_host | Host to install vhost configuration | string | - | yes |
| ssh\_private\_key | Location of private key file for SSH access to droplets | string | `~/.ssh/id_rsa` | no |
| ssl\_enabled | Enable SSL with Let's Encrypt | string | - | yes |
| stack\_name | Name of the Rancher stack | string | `whistlepost` | no |
| target\_hosts | List of target hosts for vhost configuration | list | - | yes |

