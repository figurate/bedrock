/**
 * # AWS AWstats role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create roles that has the following privileges:
 *
 * * Access for managing AWstats hosts specific to this blueprint
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

resource "aws_iam_role" "awstats_admin" {
  name = "bedrock-awstats-admin"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  role = "${aws_iam_role.awstats_admin.name}"
}

resource "aws_iam_role_policy_attachment" "iam_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  role = "${aws_iam_role.awstats_admin.name}"
}

resource "aws_iam_role_policy_attachment" "cloudformation_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess"
  role = "${aws_iam_role.awstats_admin.name}"
}

resource "aws_iam_role_policy_attachment" "iam_passrole" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-iam-passrole"
  role = "${aws_iam_role.awstats_admin.id}"
}

resource "aws_iam_role_policy_attachment" "cloudformation_create" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-cloudformation-create"
  role = "${aws_iam_role.awstats_admin.id}"
}
