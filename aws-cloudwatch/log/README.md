Provision a CloudWatch Log Group

## Requirements

| Name | Version |
|------|---------|
| aws | >= 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.7.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_role\_account | AWS account ID for the role to assume into | `any` | `null` | no |
| context | Contextual naming of the log group (eg. user, service, etc.) | `string` | `""` | no |
| environment | The name of the environment associated with the log group | `any` | n/a | yes |
| retention\_days | How many days to retain logs in the log group | `number` | `14` | no |
| service\_name | The log group name | `any` | n/a | yes |
| service\_type | The type of service this log group is for (used to prefix the name) | `string` | `""` | no |

## Outputs

No output.

