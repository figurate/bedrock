variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default = "cloudformation"
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
}

variable "hosted_zone" {
  description = "A Route53 hosted zone to associate the ECS cluster endpoint"
}

locals {
  env_string = ""
  account_hash = "${substr(sha256(data.aws_caller_identity.current.account_id), -10, 10)}"
}
