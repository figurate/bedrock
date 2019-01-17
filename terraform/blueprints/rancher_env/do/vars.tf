variable "rancher_url" {
  description = "Base URL of Rancher API"
  default = "http://rancher.mnode.org"
}

variable "rancher_access_key" {
  description = "Rancher API access key"
}

variable "rancher_secret_key" {
  description = "Rancher API secret key"
}

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

locals {
  uuid = "${var.environment}-rancherstack"
}
