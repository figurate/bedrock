data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "rds_cycle" {
  statement {
    actions = [
      "rds:StopDBInstance",
      "rds:StartDBInstance",
      "rds:StopDBCluster",
      "rds:StartDBCluster",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "cloudwatch:Describe*",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "rds_snapshot" {
  statement {
    actions = [
      "rds:StopDBInstance",
      "rds:StartDBInstance",
      "rds:StopDBCluster",
      "rds:StartDBCluster",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "cloudwatch:Describe*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "rds_cycle" {
  name               = "bedrock-rds-cycle-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "rds_cycle" {
  policy = "${data.aws_iam_policy_document.rds_cycle.json}"
  role   = "${aws_iam_role.rds_cycle.id}"
}

resource "aws_iam_role" "rds_snapshot" {
  name               = "bedrock-rds-snapshot-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "rds_snapshot" {
  policy = "${data.aws_iam_policy_document.rds_snapshot.json}"
  role   = "${aws_iam_role.rds_snapshot.id}"
}
