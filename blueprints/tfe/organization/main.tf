module "organization" {
  source = "figurate/organization/tfe"

  admin = var.admin
  name  = var.name
}
