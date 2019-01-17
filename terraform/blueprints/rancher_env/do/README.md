# Rancher environment configuration

Provision an environment on a Rancher server instance.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enabled | Start/stop the rancher environment | string | - | yes |
| environment | Environment identifier for the rancher hosts | string | - | yes |
| host\_count | The number of hosts to create | string | `1` | no |
| rancher\_access\_key | Rancher API access key | string | - | yes |
| rancher\_secret\_key | Rancher API secret key | string | - | yes |
| rancher\_url | Base URL of Rancher API | string | `http://rancher.mnode.org` | no |

