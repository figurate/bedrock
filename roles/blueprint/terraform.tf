data "aws_iam_policy_document" "s3_terraform_access" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = ["arn:aws:s3:::${data.aws_caller_identity.current.account_id}-terraform-state/*"]
  }
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::${data.aws_caller_identity.current.account_id}-terraform-state"]
  }
}

data "aws_iam_policy_document" "dynamodb_terraform_access" {
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]
    resources = ["arn:aws:dynamodb:*:*:table/terraform-lock"]
  }
}

resource "aws_iam_policy" "s3_terraform_access" {
  name        = "bedrock-terraform-state"
  description = "Manage persisted state for Terraform"
  policy      = data.aws_iam_policy_document.s3_terraform_access.json
}

resource "aws_iam_policy" "dynamodb_terraform_access" {
  name        = "bedrock-terraform-locking"
  description = "Manage execution locking for Terraform"
  policy      = data.aws_iam_policy_document.dynamodb_terraform_access.json
}
