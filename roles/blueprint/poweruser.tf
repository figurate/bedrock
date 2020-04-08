data "aws_iam_policy_document" "poweruser_boundary_policy" {
  statement {
    actions = [
      "iam:*",
    ]
    resources = ["arn:aws:cloudformation:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
}

resource "aws_iam_policy" "poweruser_boundary" {
  name        = "bedrock-poweruser-boundary"
  description = "Restrict IAM functions to the specified region"
  policy      = data.aws_iam_policy_document.poweruser_boundary_policy.json
}
