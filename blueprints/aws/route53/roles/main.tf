/**
 * # AWS Route53 role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create a role that has the following privileges:
 *
 * * Route53 access for creation of hosted zones specific to this blueprint
 * * Access to read/write Terraform state associated with the account
 */
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role" "route53admin" {
  name               = "bedrock-route53-admin"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "route53_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role       = "${aws_iam_role.route53admin.name}"
}

resource "aws_iam_role_policy_attachment" "vpc_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCReadOnlyAccess"
  role       = "${aws_iam_role.route53admin.name}"
}

resource "aws_iam_role_policy_attachment" "route53_additional" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-route53-zoneaccess"
  role       = "${aws_iam_role.route53admin.name}"
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = "${aws_iam_role.route53admin.id}"
}
