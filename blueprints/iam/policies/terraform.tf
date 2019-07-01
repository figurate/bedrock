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

resource "aws_iam_policy" "s3_terraform_access" {
  name   = "bedrock-terraform-state"
  policy = data.aws_iam_policy_document.s3_terraform_access.json
}
