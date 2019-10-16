## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| description | Description of the trigger event rule | string | - | yes |
| function\_input | A map of values passed to the function invocation | map | `<map>` | no |
| function\_name | Name of the Lambda function triggered by bucket changes | string | - | yes |
| region | AWS default region | string | - | yes |
| trigger\_name | Name of the trigger event rule | string | - | yes |
| trigger\_schedule | CRON expression for trigger | string | - | yes |

