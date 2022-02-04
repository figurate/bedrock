# EFS Filesystem Creation

Create an EFS filesystem and mount points.

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
| context | Contextual naming of the ECS cluster (eg. user, service, etc.) | `string` | `""` | no |
| environment | The name of the environment associated with the cluster | `any` | n/a | yes |
| vpc\_default | Indicate whether to deploy in the default VPC | `bool` | `true` | no |
| vpc\_tags | A map of tags to match on the VPC lookup | `map(any)` | `{}` | no |

## Outputs

No output.

