/**
 * # AWS SpotFleet cluster configuration
 *
 * Provision a Spot Fleet cluster.
 */
data "aws_caller_identity" "current" {}

data "aws_ami" "spotfleet_image" {
  filter {
    name = "name"
    values = ["${var.image_name}"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
  most_recent = true
  owners = ["${replace(var.image_owner, "/\\A\\z/", data.aws_caller_identity.current.account_id)}"]
}

resource "aws_cloudformation_stack" "spotfleet" {
  name = "${var.environment}-spotfleet"
  parameters {
    Environment = "${var.environment}"
  }
  template_body = "${file(format("%s/spotfleet.yml", var.cloudformation_path))}"
}
