/**
 * # AWS VPC configuration
 *
 * Provision a VPC for an environment.
 */
data "aws_iam_role" "vpc_cloudformation" {
  name = "bedrock-vpc-cloudformation"
}

resource "aws_cloudformation_stack" "vpc" {
  name         = "${var.environment}-vpc"
  iam_role_arn = "${data.aws_iam_role.vpc_cloudformation.arn}"
  parameters {
    CidrBlock   = "${var.cidr_block}"
    Environment = "${var.environment}"
  }
  template_body = "${file(format("%s/vpc.yml", var.cloudformation_path))}"
}
