module "organization" {
  source = "figurate/organization/tfe"

  name  = var.name
  admin = var.admin
}
