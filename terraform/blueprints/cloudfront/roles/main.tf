/**
 * # AWS EC2 role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create roles that has the following privileges:
 *
 * * Access for managing Cloudfront distributions specific to this blueprint
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

resource "aws_iam_role" "cloudfront_admin" {
  name = "bedrock-cloudfront-admin"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "cloudfront_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
  role = "${aws_iam_role.cloudfront_admin.name}"
}

resource "aws_iam_role_policy_attachment" "s3_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role = "${aws_iam_role.cloudfront_admin.name}"
}

resource "aws_iam_role_policy_attachment" "route53_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role = "${aws_iam_role.cloudfront_admin.name}"
}
