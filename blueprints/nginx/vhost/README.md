# NGINX vhost configuration

Configure a vhost on an existing NGINX installation.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_host | Bastion host used to access reverse proxy | string | - | yes |
| environment | Environment identifier for the rancher hosts | string | `default` | no |
| error\_bg\_image | Path to background image used for error pages | string | - | yes |
| hostnames | Hostname to configure in virtual host | list | - | yes |
| letsencrypt\_email | Email address to register with Letsencrypt | string | - | yes |
| locations\_config | A file containing NGINX location directives | string | - | yes |
| reverseproxy\_host | Host to install vhost configuration | string | - | yes |
| reverseproxy\_user | Username for SSH to reverseproxy host | string | `root` | no |
| ssh\_private\_key | Location of private key file for SSH access to reverseproxy host | string | `~/.ssh/id_rsa` | no |
| ssl\_enabled | Enable SSL with Let's Encrypt | string | - | yes |
| static\_host | A static site for redirection of requests | string | `` | no |
| target\_hosts | List of target hosts for vhost configuration | list | - | yes |
| target\_type | Indicates the type of vhost configuration to use | string | - | yes |
| template\_path | The root path to vhost templates | string | `templates` | no |

