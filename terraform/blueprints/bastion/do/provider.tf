provider "digitalocean" {
  token = "${var.do_token}"
  version = "~> 0.1"
}

variable "do_token" {
  description = "Digital Ocean API token"
}

variable "do_region" {
  description = "Digital Ocean region"
}

provider "null" {
  version = "~> 1.0"
}
