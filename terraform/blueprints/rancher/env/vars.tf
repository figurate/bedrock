variable "enabled" {
  description = "Start/stop the rancher environment"
}

variable "environment" {
  description = "Environment identifier for the rancher hosts"
}

variable "host_count" {
  description = "The number of hosts to create"
  default = "1"
}

variable "region" {
  description = "Digitalocean region of the rancher environment"
}

locals {
  uuid = "${var.environment}-rancherstack"
}
