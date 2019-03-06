/**
 * # AWS IAM policies
 *
 * Purpose: Provision IAM policies in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create policies for common activities that may be attached to roles.
 */
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "iam_passrole_policy" {
  statement {
    actions = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]
  }
}

data "aws_iam_policy_document" "cloudformation_create_policy" {
  statement {
    actions = [
      "cloudformation:Create*",
      "cloudformation:Update*",
      "cloudformation:Delete*",
    ]
    resources = ["arn:aws:cloudformation:${var.region}:${data.aws_caller_identity.current.account_id}:stack/*"]
  }
}

resource "aws_iam_policy" "iam_passrole" {
  name = "bedrock-iam-passrole"
  policy = "${data.aws_iam_policy_document.iam_passrole_policy.json}"
}

resource "aws_iam_policy" "cloudformation_create" {
  name = "bedrock-cloudformation-create"
  policy = "${data.aws_iam_policy_document.cloudformation_create_policy.json}"
}
