/**
 * # AWS reverse proxy configuration
 *
 * Provision an NGINX reverse proxy for an environment.
 */
data "aws_caller_identity" "current" {}

data "aws_ami" "autoscaling_image" {
  filter {
    name = "name"
    values = ["${var.image_name}"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners = ["${replace(var.image_owner, "/\\A\\z/", data.aws_caller_identity.current.account_id)}"]
}

resource "aws_cloudformation_stack" "reverseproxy" {
  name = "${var.environment}-reverseproxy"
  parameters {
    Environment = "${var.environment}"
  }
  template_body = "${file(format("%s/reverseproxy.yml", var.cloudformation_path))}"
}
