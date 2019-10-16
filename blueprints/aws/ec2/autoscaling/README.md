# AWS Autoscaling configuration

Provision an auto scaling EC2 architecture.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudformation\_path | The root path to cloudformation templates | string | `cloudformation` | no |
| environment | The name of the environment applied to the RDS stack | string | - | yes |
| image\_name | AWS image for autoscaling launch configuration | string | `amzn2-ami-hvm-*` | no |
| image\_owner | AMI image owner (leave blank for current account) | string | `137112412989` | no |
| instance\_type | AWS instance type for launch configuration | string | `t2.micro` | no |
| region | AWS default region | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| ami\_id | - |

