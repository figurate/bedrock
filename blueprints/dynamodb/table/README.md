# DynamoDB Create Table

Support creation of DynamoDB tables.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| db\_attributes | A list of attributes (columns) in the table | list | - | yes |
| db\_hash\_key | The primary key column in the table | string | - | yes |
| db\_table | The name of the DynamoDB table to provision | string | - | yes |
| range\_key | The sort key column in the table | string | - | yes |
| region | AWS default region | string | - | yes |

