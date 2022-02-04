provider "rancher" {
  api_url    = var.rancher_url
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
}

variable "rancher_url" {
  description = "Base URL of Rancher API"
  default     = "http://rancher.mnode.org"
}

variable "rancher_access_key" {
  description = "Rancher API access key"
}

variable "rancher_secret_key" {
  description = "Rancher API secret key"
}
