variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default     = "cloudformation"
}

variable "cluster_template" {
  description = "The CloudFormation template used to create the ECS cluster SpotFleet"
  default     = "ecs_spotfleet"
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

variable "appmesh_enabled" {
  description = "Enable AppMesh for the cluster"
  default     = "False"
  //  validation {
  //    condition = var.appmesh_enabled == "true" || var.appmesh_enabled == "false"
  //    error_message = "Must be a boolean value"
  //  }
}

variable "image_name" {
  description = "AWS image for Sling instance"
  default     = "amzn2-ami-ecs-hvm-2.0.????????-x86_64-ebs"
}

variable "image_owner" {
  description = "AMI image owner (leave blank for current account)"
  default     = "591542846629"
}

variable "instance_type" {
  description = "AWS instance type for Sling"
  default     = "t3.micro"
}

variable "nodes_max" {
  description = "Maximum allowed nodes in the cluster"
  type        = number
  default     = 1
}

variable "nodes_min" {
  description = "Minimum required nodes in the cluster"
  type        = number
  default     = 1
}

variable "nodes_desired" {
  description = "Suggested nodes in the cluster"
  type        = number
  default     = 1
}

locals {
  env_string   = var.context == "" ? var.environment : format("%s-%s", var.environment, var.context)
  cluster_name = var.context == "" ? format("%s-cluster", var.environment) : format("%s-cluster-%s", var.environment, var.context)
  account_hash = substr(sha256(data.aws_caller_identity.current.account_id), -10, 10)
}
