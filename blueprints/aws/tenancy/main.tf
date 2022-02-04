data "aws_vpc" "tenant" {
  default = var.vpc_default
  tags    = var.vpc_tags
}

module "dns" {
  source = "./modules/dns"

  name         = "Micronode"
  public_zone  = "mnode.org"
  private_zone = "mnode.internal"
  vpc          = data.aws_vpc.tenant.id
}

module "iam" {
  source = "./modules/iam"

  aws_account_id                  = var.aws_account_id
  support_iam_role_principal_arns = var.support_iam_role_principal_arns
}

module "monitoring" {
  source = "./modules/monitoring"
}

module "storage" {
  source = "./modules/storage"
}
