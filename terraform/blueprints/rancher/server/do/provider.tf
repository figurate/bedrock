provider "digitalocean" {
  token = "${var.do_token}"
  version = "~> 0.1"
}

provider "null" {
  version = "~> 1.0"
}

variable "do_token" {
  description = "Digital Ocean API token"
}

variable "do_region" {
  description = "Digital Ocean region"
}
