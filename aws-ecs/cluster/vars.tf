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
  type        = map(any)
  description = "A map of tags to match on the VPC lookup"
  default     = {}
}

variable "private_routing" {
  description = "Indicates whether private routing (zone) is enabled"
  default     = "True"
  //  validation {
  //    condition = var.private_routing == "true" || var.private_routing == "false"
  //    error_message = "Must be a boolean value"
  //  }
}

variable "servicemesh_enabled" {
  description = "Enable service mesh for the cluster"
  default     = false
}

variable "service_namespace" {
  description = "The namespace to use for service discovery (leave blank for default namespace)"
  default     = ""
}

variable "efs_enabled" {
  description = "Enable EFS filesystem for persistent volumes"
  default     = false
}

locals {
  env_string        = var.context == "" ? var.environment : format("%s-%s", var.environment, var.context)
  cluster_name      = var.context == "" ? format("%s-cluster", var.environment) : format("%s-cluster-%s", var.environment, var.context)
  account_hash      = substr(sha256(data.aws_caller_identity.current.account_id), -10, 10)
  default_namespace = replace(var.service_namespace, "/\\A\\z/", "${local.env_string}.internal")

  efs_subnets = var.efs_enabled ? data.aws_subnet_ids.tenant.ids : []
}
