/*
 * # Terraform Organizations
 * Provision a list of Terraform organizations
 * ![Terraform](terraform.png)
 */
module "organization" {
  source                   = "figurate/organization/tfe"
  count                 = length(var.organizations)
  name                     = var.organizations[count.index][0]
  admin                    = var.organizations[count.index][1]
  collaborator_auth_policy = "two_factor_mandatory"
}
