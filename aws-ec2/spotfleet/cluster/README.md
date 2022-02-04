# AWS SpotFleet cluster configuration

Provision a Spot Fleet cluster.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudformation\_path | The root path to cloudformation templates | string | `cloudformation` | no |
| environment | The name of the environment applied to the cluster | string | - | yes |
| image\_name | AWS image for spotfleet launch specification | string | `amzn2-ami-hvm-*` | no |
| image\_owner | AMI image owner (leave blank for current account) | string | `137112412989` | no |
| instance\_type | AWS instance type for launch specification | string | `t2.micro` | no |
| region | AWS default region | string | - | yes |

