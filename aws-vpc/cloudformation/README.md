# AWS VPC configuration

Provision a VPC for an environment.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| cidr\_block | The CIDR block covered by the VPC. For example: 10.0.0.0/16 | string | - | yes |
| cloudformation\_path | The root path to cloudformation templates | string | `cloudformation` | no |
| environment | The name of the environment represented by the VPC | string | - | yes |
| region | AWS default region | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_id | - |

