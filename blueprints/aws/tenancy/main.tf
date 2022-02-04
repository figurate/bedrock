data "aws_vpc" "tenant" {
  default = var.vpc_default
  tags    = var.vpc_tags
}

module "cloudmap" {
  source = "../cloudmap"

  name         = "Micronode"
  public_zone  = "mnode.org"
  private_zone = "mnode.internal"
  vpc          = data.aws_vpc.tenant.id
}

module "iam" {
  source = "../iam"

  aws_account_id                  = var.aws_account_id
  support_iam_role_principal_arns = var.support_iam_role_principal_arns
}

module "cloudwatch" {
  source = "../cloudwatch"
}

module "ec2" {
  source = "../ec2"
}
