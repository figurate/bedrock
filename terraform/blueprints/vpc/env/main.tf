/**
 * # AWS VPC configuration
 *
 * Provision a VPC for an environment.
 */
resource "aws_cloudformation_stack" "vpc" {
  name = "${var.environment}-vpc"
  parameters {
    CidrBlock = "${var.cidr_block}"
    Environment = "${var.environment}"
  }
  template_body = "${file(format("%s/vpc.yml", var.cloudformation_path))}"
}
