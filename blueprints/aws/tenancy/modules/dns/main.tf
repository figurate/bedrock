module "public_dns" {
  source = "figurate/service-discovery-namespace/aws"

  name           = var.public_zone
  description    = "Public DNS for ${var.name} namespace"
  namespace_type = "public"
}

module "private_dns" {
  source = "figurate/service-discovery-namespace/aws"

  name           = var.private_zone
  description    = "Private DNS for ${var.name} namespace"
  namespace_type = "private"
  vpc            = var.vpc
}
