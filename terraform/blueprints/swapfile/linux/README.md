# Linux swap configuration

Configure a swap file on a Linux host.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastion\_host | Bastion host used to access target host | string | - | yes |
| bastion\_private\_key | Location of private key file for SSH access to bastion host | string | `~/.ssh/id_rsa` | no |
| ssh\_private\_key | Location of private key file for SSH access to droplets | string | `~/.ssh/id_rsa` | no |
| target\_host | The target host for the remote execution | string | - | yes |

