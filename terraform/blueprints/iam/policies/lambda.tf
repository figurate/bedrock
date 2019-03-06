data "aws_iam_policy_document" "lambda_dynamodb_fullaccess" {
  statement {
    actions = [
      "dynamodb:List*",
      "dynamodb:Describe*",
      "dynamodb:Get*",
      "dynamodb:PutItem",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "lambda_logs" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_dynamodb_fullaccess" {
  name = "bedrock-lambda-dynamodb-fullaccess"
  policy = "${data.aws_iam_policy_document.lambda_dynamodb_fullaccess.json}"
}

resource "aws_iam_policy" "lambda_logs" {
  name = "bedrock-lambda-logs"
  policy = "${data.aws_iam_policy_document.lambda_logs.json}"
}
