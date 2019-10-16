data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "dynamodb_import" {
  name               = "bedrock-dynamodb-import-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "s3_readonly_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = "${aws_iam_role.dynamodb_import.id}"
}

resource "aws_iam_role_policy_attachment" "dynamodb_fullaccess" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-dynamodb-fullaccess"
  role       = "${aws_iam_role.dynamodb_import.id}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-cloudwatch-logs"
  role       = "${aws_iam_role.dynamodb_import.id}"
}

resource "aws_iam_role" "dynamodb_put" {
  name               = "bedrock-dynamodb-put-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "put_dynamodb_fullaccess" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-dynamodb-fullaccess"
  role       = "${aws_iam_role.dynamodb_put.id}"
}

resource "aws_iam_role_policy_attachment" "put_cloudwatch_logs" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-cloudwatch-logs"
  role       = "${aws_iam_role.dynamodb_put.id}"
}
