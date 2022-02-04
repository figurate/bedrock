# Terraform Organizations  
Provision a list of Terraform organizations
![Terraform](terraform.png)

## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| membership | A list of organization team members | `list(string)` | `[]` | no |
| organizations | A list of organization names and administrators | `list(tuple([string, string]))` | `[]` | no |

## Outputs

No output.

