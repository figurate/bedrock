/*
 * ![Terraform](terraform.png)
 */
module "s3_remote_state" {
  source = "./s3-remote-state"
  count  = var.backend_type == "s3" ? 1 : 0

  mfa_delete = var.mfa_delete
}

module "tfe_organization" {
  source = "./organization"
  count  = var.backend_type == "tfe" ? 1 : 0

  name       = var.name
  admin      = var.admin
  membership = var.membership
}
