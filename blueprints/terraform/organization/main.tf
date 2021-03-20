module "organization" {
  source = "figurate/organization/tfe"

  name                     = var.name
  admin                    = var.admin
  collaborator_auth_policy = "two_factor_mandatory"
}
