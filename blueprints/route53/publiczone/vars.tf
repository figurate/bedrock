variable "fqdn" {
  description = "A fully qualified domain name (FQDN) that is the basis for the hosted zone"
}

variable "apex_redirect_fqdn" {
  description = "The FQDN to redirect requests for the apex domain of the hosted zone"
  default = ""
}

variable "source_cidrs" {
  description = "Restrict S3 website access to the specified CIDR blocks of IP addresses"
  type = "list"
  default = ["0.0.0.0/0"]
}
