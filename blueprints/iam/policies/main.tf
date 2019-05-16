/**
 * # AWS IAM policies
 *
 * Purpose: Provision IAM policies in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create policies for common activities that may be attached to roles. Policies are grouped
 * according to the AWS services/APIs to which access is granted.
 *
 * Typically IAM policies are a group of permissions that allows a particular activity, such as writing
 * logs to Cloudwatch, provisioning DynamoDB tables, etc.
 */
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "iam_passrole_policy" {
  statement {
    actions = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]
  }
}

resource "aws_iam_policy" "iam_passrole" {
  name = "bedrock-iam-passrole"
  policy = "${data.aws_iam_policy_document.iam_passrole_policy.json}"
}
