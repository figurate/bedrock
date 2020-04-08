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

data "aws_iam_policy_document" "cloudwatch_log_groups" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DeleteLogGroup",
      "logs:DescribeLogGroups",
      "logs:PutRetentionPolicy",
    ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
}

resource "aws_iam_policy" "cloudwatch_logs" {
  name        = "bedrock-cloudwatch-logs"
  description = "Manage CloudWatch log entries"
  policy      = data.aws_iam_policy_document.cloudwatch_logs.json
}

resource "aws_iam_policy" "cloudwatch_log_groups" {
  name        = "bedrock-cloudwatch-log-groups"
  description = "Manage CloudWatch log groups"
  policy      = data.aws_iam_policy_document.cloudwatch_log_groups.json
}
