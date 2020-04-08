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

resource "aws_iam_policy" "cloudformation_create" {
  name        = "bedrock-cloudformation-create"
  description = "Manage CloudFormation stacks"
  policy      = data.aws_iam_policy_document.cloudformation_create_policy.json
}
