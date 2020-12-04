variable "vpc_default" {
  description = "Use the default VPC for private namespaces"
  default     = true
}

variable "vpc_tags" {
  type        = map(any)
  description = "Lookup tags to identify VPC for private namespaces"
  default     = {}
}

variable "aws_account_id" {}

variable "support_iam_role_principal_arns" {}