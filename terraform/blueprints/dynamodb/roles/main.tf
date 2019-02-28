/**
 * # AWS DynamoDB role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create roles that has the following privileges:
 *
 * * Access for managing DynamoDB tables specific to this blueprint
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
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock-dynamodb-import-role"]
  }
}

data "aws_iam_policy_document" "iam_access" {
  statement {
    actions = [
      "iam:PutRolePolicy",
      "iam:GetRolePolicy",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock-dynamodb-import-role"]
  }
  statement {
    actions = [
      "lambda:*",
    ]
    resources = ["arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:DynamoDBImportCsv"]
  }
  statement {
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "dynamodb_admin" {
  name = "bedrock-dynamodb-admin"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "dynamodb_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role = "${aws_iam_role.dynamodb_admin.name}"
}

resource "aws_iam_role_policy" "iam_access" {
  role = "${aws_iam_role.dynamodb_admin.id}"
  policy = "${data.aws_iam_policy_document.iam_access.json}"
}

resource "aws_iam_role_policy" "iam_passrole" {
  policy = "${data.aws_iam_policy_document.iam_passrole_policy.json}"
  role = "${aws_iam_role.dynamodb_admin.id}"
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role = "${aws_iam_role.dynamodb_admin.id}"
}
