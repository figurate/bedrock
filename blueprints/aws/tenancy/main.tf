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
