/**
 * Provision resources for an AWS application.
 *
 * - A VPC within the AWS tenancy to isolate application services
 */
module "vpc" {
  source = ""
}

module "subnets" {
  source = ""
}

module "security_groups" {
  source = ""
}
