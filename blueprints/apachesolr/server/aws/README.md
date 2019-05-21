# AWS Solr host configuration

Provision an EC2 instance with Apache Solr installed.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| cloudformation\_path | The root path to cloudformation templates | string | `cloudformation` | no |
| environment | The name of the environment associated with the host | string | - | yes |
| hosted\_zone | Hosted zone identifier for DNS entry | string | - | yes |
| image\_name | AWS image for Solr instance | string | `amzn2-ami-hvm-*` | no |
| image\_os | The operating system installed on the selected AMI. Valid values are:<br><br>  * al2     = Amazon Linux 2 | string | `al2` | no |
| image\_owner | AMI image owner (leave blank for current account) | string | `137112412989` | no |
| instance\_type | AWS instance type for Solr | string | `t3.micro` | no |
| region | AWS default region | string | - | yes |
| solr\_user | Username for Solr SSH user | string | - | yes |
| solr\_version | The major release version of Apache Solr to use | string | `10` | no |
| ssh\_key | Location of public key file for SSH access to host | string | `~/.ssh/id_rsa.pub` | no |
| userdata\_path | The root path to userdata templates | string | `userdata` | no |
| vpc\_default | Boolean value to indicate whether the matched VPC should be default for the region | string | `true` | no |
| vpc\_tags | A list of tags to match on the VPC lookup | list | `<list>` | no |

