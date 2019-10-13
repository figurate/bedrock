variable template_path {
  description = "The root path to container templates"
  default     = "templates"
}

variable environment {
  description = "Environment categorisation used in the naming of the ECS cluster"
}

variable "region" {
  description = "AWS default region"
}

variable context {
  description = "Contextual categorisation used in the naming of the ECS cluster"
  default     = ""
}

variable vpc_default {
  description = "Boolean value to indicate whether the matched VPC should be default for the region"
  default     = "true"
}

variable vpc_tags {
  type        = "map"
  description = "A map of tags to match on the VPC lookup"
  default     = {}
}

variable task_type {
  description = "The type of task definition to apply. Valid values include: default, fargate, with-config"
  default     = "default"
}

variable service_name {
  description = "Name of the ECS service"
}

variable service_port {
  description = "Container port of the ECS service"
}

variable service_image {
  description = "Docker image used for the service"
}

variable service_cpu {
  description = "Minimum CPU units required (1024 = 1 vCPU)"
  default     = 256
}

variable service_memory {
  description = "Minimum amount of memory required (in MiB)"
  default     = 512
}

variable network_mode {
  description = "Network mode used by service containers"
  default     = "bridge"
}

variable launch_type {
  description = "Type of deployment infrastructure (EC2 or FARGATE)"
  default     = "EC2"
}

locals {
  service_id   = var.context != "" ? format("%s-%s-%s", var.environment, replace(var.service_name, "/", "-"), var.context) : format("%s-%s", var.environment, replace(var.service_name, "/", "-"))
  cluster_name = var.context != "" ? format("%s-cluster-%s", var.environment, var.context) : format("%s-cluster", var.environment)
}
