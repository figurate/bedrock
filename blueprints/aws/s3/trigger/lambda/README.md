## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| bucket\_name | Name of the source S3 bucket | string | - | yes |
| filter\_suffix | A suffix filter that identifies bucket objects that can trigger the function | string | - | yes |
| function\_name | Name of the Lambda function triggered by bucket changes | string | - | yes |
| region | AWS default region | string | - | yes |
| trigger\_events | A list of bucket events that trigger the function | list | `<list>` | no |

