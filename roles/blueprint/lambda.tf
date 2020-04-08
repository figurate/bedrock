data "aws_iam_policy_document" "lambda_config" {
  statement {
    actions = [
      "lambda:GetFunction*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_config" {
  name        = "bedrock-lambda-config"
  description = "Retrieve Lambda functions"
  policy      = data.aws_iam_policy_document.lambda_config.json
}
