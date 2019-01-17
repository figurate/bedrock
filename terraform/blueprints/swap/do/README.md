# Linux swap configuration

Configure a swap file on a Linux host.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_host | Bastion host used to access reverse proxy | string | - | yes |
| ssh\_private\_key | Location of private key file for SSH access to droplets | string | `~/.ssh/id_rsa` | no |
| target\_host | The target host for the remote execution | string | - | yes |

