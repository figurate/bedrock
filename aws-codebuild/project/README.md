# AWS Codebuild configuration

Provision a codebuild with the following features:

 - Dedicated user with limited permissions
 - Build parameters stored in SSM Parameter Store
 - KMS encryption of sensitive build parameters
 - Configurable build container


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| build\_timeout | Maximum build time in minutes | string | `5` | no |
| codebuild\_image | Docker image used to run build specs | string | `hashicorp/terraform:light` | no |
| codecommit\_repo | The source repository for the codebuild specification | string | - | yes |
| region | AWS default region | string | - | yes |

