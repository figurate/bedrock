## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| autoscale\_desired | Minimum number of EC2 nodes to attach to the cluster | string | `0` | no |
| autoscale\_max | Maximum number of EC2 nodes to attach to the cluster | string | `0` | no |
| autoscale\_min | Minimum number of EC2 nodes to attach to the cluster | string | `0` | no |
| cloudformation\_path | The root path to cloudformation templates | string | `cloudformation` | no |
| cluster\_name | Name of the ECS cluster | string | - | yes |
| image\_name | AWS image for bastion instance | string | `amzn2-ami-ecs-hvm-*` | no |
| image\_owner | AMI image owner (leave blank for current account) | string | `591542846629` | no |
| instance\_type | AWS instance type for ECS nodes | string | `t3.micro` | no |
| region | AWS default region | string | - | yes |
| spot\_price | A non-zero value indicates a maximum spot price | string | `0` | no |

