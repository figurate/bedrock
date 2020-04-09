variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default     = "cloudformation"
}

variable "cluster_template" {
  description = "The CloudFormation template used to create the ECS cluster"
  default     = "ecs_cluster"
}

variable "environment" {
  description = "The name of the environment associated with the cluster"
}

variable "context" {
  description = "Contextual naming of the ECS cluster (eg. user, service, etc.)"
  default     = ""
}

variable "vpc_default" {
  description = "Indicate whether to deploy in the default VPC"
  default     = true
}

variable "vpc_tags" {
  type        = "map"
  description = "A map of tags to match on the VPC lookup"
  default     = {}
}

variable "zone_name" {
  description = "A Route53 hosted zone to associate the ECS cluster endpoint"
}

variable "private_routing" {
  description = "Indicates whether private routing (zone) is enabled"
  default     = "True"
  //  validation {
  //    condition = var.private_routing == "true" || var.private_routing == "false"
  //    error_message = "Must be a boolean value"
  //  }
}

variable "appmesh_enabled" {
  description = "Enable AppMesh for the cluster"
  default     = "False"
  //  validation {
  //    condition = var.appmesh_enabled == "true" || var.appmesh_enabled == "false"
  //    error_message = "Must be a boolean value"
  //  }
}

locals {
  env_string   = var.context == "" ? var.environment : format("%s-%s", var.environment, var.context)
  cluster_name = var.context == "" ? format("%s-cluster", var.environment) : format("%s-cluster-%s", var.environment, var.context)
  account_hash = substr(sha256(data.aws_caller_identity.current.account_id), -10, 10)
}
