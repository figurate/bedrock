data "aws_iam_policy_document" "cloudwatch_logs" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]
    resources = ["arn:aws:logs:${data.aws_caller_identity.current.account_id}:log-group:*"]
  }
}

resource "aws_iam_policy" "cloudwatch_logs" {
  name = "bedrock-cloudwatch-logs"
  policy = "${data.aws_iam_policy_document.cloudwatch_logs.json}"
}
