variable "fqdn" {
  description = "A fully qualified domain name (FQDN) that is the basis for the hosted zone"
}

variable "vpc_id" {
  description = "Identifier of VPC to associated private zone with (leave blank to indicate default VPC)"
  default = ""
}
