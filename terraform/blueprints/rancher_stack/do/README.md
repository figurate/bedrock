## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_host | Bastion host used to access reverse proxy | string | - | yes |
| catalog\_id | ID of predefined stack in Rancher catalog | string | `` | no |
| docker\_compose | Location of docker-compose file | string | `docker-compose.yml` | no |
| enabled | Start/stop the rancher stack | string | - | yes |
| environment | Environment identifier for the rancher hosts | string | - | yes |
| hostname | Hostname to configure in virtual host | string | - | yes |
| rancher\_access\_key | Rancher API access key | string | - | yes |
| rancher\_compose | Location of rancher-compose file | string | `rancher-compose.yml` | no |
| rancher\_secret\_key | Rancher API secret key | string | - | yes |
| rancher\_url | Base URL of Rancher API | string | `http://rancher.mnode.org` | no |
| reverseproxy\_host | Host to install vhost configuration | string | - | yes |
| ssh\_private\_key | Location of private key file for SSH access to droplets | string | `~/.ssh/id_rsa` | no |
| ssl\_enabled | Enable SSL with Let's Encrypt | string | - | yes |
| stack\_name | Name of the Rancher stack | string | - | yes |
| target\_hosts | List of target hosts for vhost configuration | list | - | yes |
| target\_port | Target port for vhost configuration | string | `8080` | no |

