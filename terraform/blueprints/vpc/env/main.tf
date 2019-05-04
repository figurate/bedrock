/**
 * # AWS VPC configuration
 *
 * Provision a VPC for an environment.
 */
data "aws_availability_zones" "available" {}

data "aws_iam_role" "vpc_cloudformation" {
  name = "bedrock-vpc-cloudformation"
}

resource "aws_cloudformation_stack" "vpc" {
  name = "${var.environment}-vpc"
  iam_role_arn = "${data.aws_iam_role.vpc_cloudformation.arn}"
  parameters {
    CidrBlock = "${var.cidr_block}"
    Environment = "${var.environment}"
  }
  template_body = "${file(format("%s/vpc.yml", var.cloudformation_path))}"
}

resource "aws_subnet" "private_subnets" {
  count = "${length(data.aws_availability_zones.available.zone_ids)}"
  availability_zone_id = "${element(data.aws_availability_zones.available.zone_ids, count.index)}"
  map_public_ip_on_launch = false
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id = "${aws_cloudformation_stack.vpc.outputs["VpcId"]}"
  tags {
    Name = "${format("private_subnet_%s", substr(element(data.aws_availability_zones.available.names, count.index), -2, -1))}"
  }
}

resource "aws_subnet" "public_subnets" {
  count = "${length(data.aws_availability_zones.available.zone_ids)}"
  availability_zone_id = "${element(data.aws_availability_zones.available.zone_ids, count.index)}"
  map_public_ip_on_launch = true
  cidr_block = "10.0.${255 - count.index}.0/24"
  vpc_id = "${aws_cloudformation_stack.vpc.outputs["VpcId"]}"
  tags {
    Name = "${format("public_subnet_%s", substr(element(data.aws_availability_zones.available.names, count.index), -2, -1))}"
  }
}
