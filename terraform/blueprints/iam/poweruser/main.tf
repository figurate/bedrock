/**
 * # AWS IAM user configuration
 *
 * Purpose: Provision an IAM user in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create a user that has the following privileges:
 *
 * * IAM access for creation of IAM roles specific to a blueprint
 * * Access to read/write Terraform state associated with the account
 * * Access to assume roles required to provision a blueprint
 */
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["iam:ListRoles"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]
  }
  statement {
    actions = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock*"]
  }
}

resource "aws_iam_user" "poweruser" {
  name = "${var.username}"
}

resource "aws_iam_access_key" "poweruser" {
  user = "${aws_iam_user.poweruser.name}"
}

resource "aws_iam_user_policy_attachment" "s3_terraform_access" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-terraform-state"
  user = "${aws_iam_user.poweruser.name}"
}

resource "aws_iam_user_policy" "iam_assume_role" {
  policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
  user = "${aws_iam_user.poweruser.name}"
}
