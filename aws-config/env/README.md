# AWS Config Rule configuration

Provision a Config Rule.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudformation\_path | The root path to cloudformation templates | string | `cloudformation` | no |
| environment | The name of the environment applied to the RDS stack | string | - | yes |
| region | AWS default region | string | - | yes |
| rule\_ids | A list of identifers for AWS-managed rules, e.g. _EC2_INSTANCE_MANAGED_BY_SSM_ | list | `<list>` | no |

