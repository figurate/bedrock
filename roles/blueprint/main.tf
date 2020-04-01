/**
 * # AWS IAM role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create a role that has the following privileges:
 *
 * * IAM access to assume other IAM roles specific a blueprint
 * * Access to read/write Terraform state associated with the account
 * * Access to manage Terraform state locks associated with the blueprint
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

resource "aws_iam_role" "blueprintadmin" {
  name               = "bedrock-blueprint-admin"
  description        = "Bedrock role used to provision blueprints and blueprint roles"
  path               = "/bedrock/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "assumerole" {
  role       = aws_iam_role.blueprintadmin.id
  policy_arn = aws_iam_policy.iam_assumerole.arn
}

resource "aws_iam_role_policy_attachment" "terraform_state" {
  role       = aws_iam_role.blueprintadmin.id
  policy_arn = aws_iam_policy.s3_terraform_access.arn
}

resource "aws_iam_role_policy_attachment" "terraform_lock" {
  role       = aws_iam_role.blueprintadmin.id
  policy_arn = aws_iam_policy.dynamodb_terraform_access.arn
}
