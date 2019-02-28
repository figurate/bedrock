/**
 * # AWS NGINX role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create roles that has the following privileges:
 *
 * * Access for managing NGINX hosts specific to this blueprint
 * * Access to read/write Terraform state associated with the account
 */
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type = "AWS"
    }
  }
}

data "aws_iam_policy_document" "iam_passrole_policy" {
  statement {
    actions = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock-nginx-cloudformation"]
  }
}

data "aws_iam_policy_document" "cloudformation_create_policy" {
  statement {
    actions = [
      "cloudformation:Create*",
      "cloudformation:Update*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "nginx_admin" {
  name = "bedrock-nginx-admin"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  role = "${aws_iam_role.nginx_admin.name}"
}

resource "aws_iam_role_policy_attachment" "iam_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  role = "${aws_iam_role.nginx_admin.name}"
}

resource "aws_iam_role_policy_attachment" "cloudformation_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess"
  role = "${aws_iam_role.nginx_admin.name}"
}

resource "aws_iam_role_policy" "iam_passrole" {
  policy = "${data.aws_iam_policy_document.iam_passrole_policy.json}"
  role = "${aws_iam_role.nginx_admin.id}"
}

resource "aws_iam_role_policy" "cloudformation_create" {
  policy = "${data.aws_iam_policy_document.cloudformation_create_policy.json}"
  role = "${aws_iam_role.nginx_admin.id}"
}
