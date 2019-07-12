variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default     = "cloudformation"
}

variable "environment" {
  description = "Environment categorisation used in the naming of the ECS cluster"
}

variable "context" {
  description = "Contextual categorisation used in the naming of the ECS cluster"
  default     = ""
}

variable "vpc_default" {
  description = "Boolean value to indicate whether the matched VPC should be default for the region"
  default     = "true"
}

variable "vpc_tags" {
  type        = "map"
  description = "A map of tags to match on the VPC lookup"
  default     = {}
}

variable "hosted_zone" {
  description = "A Route53 hosted zone to associate the ECS cluster endpoint"
}

locals {
  env_string   = var.context == "" ? var.environment : format("%s-%s", var.environment, var.context)
  cluster_name = var.context == "" ? var.environment : format("%s-cluster-%s", var.environment, var.context)
  account_hash = substr(sha256(data.aws_caller_identity.current.account_id), -10, 10)
}
