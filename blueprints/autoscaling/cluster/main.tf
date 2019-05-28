/**
 * # AWS Autoscaling configuration
 *
 * Provision an auto scaling EC2 architecture.
 */
data "aws_caller_identity" "current" {}

data "aws_ami" "autoscaling_image" {
  filter {
    name   = "name"
    values = ["${var.image_name}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  most_recent = true
  owners      = ["${replace(var.image_owner, "/\\A\\z/", data.aws_caller_identity.current.account_id)}"]
}

resource "aws_cloudformation_stack" "autoscale" {
  name = "${var.environment}-autoscale"

  parameters {
    Environment = "${var.environment}"
  }

  template_body = "${file(format("%s/autoscaling.yml", var.cloudformation_path))}"
}
