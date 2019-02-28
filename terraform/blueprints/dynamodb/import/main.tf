data "aws_caller_identity" "current" {}

data "archive_file" "import" {
  output_path = "dynamodb_import.zip"
  type = "zip"
  source_dir = "${var.lambda_path}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type = "Service"
    }
  }
}

data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    actions = [
      "dynamodb:List*",
      "dynamodb:Describe*",
      "dynamodb:Get*",
      "dynamodb:PutItem",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]
    resources = ["*"]
  }
  statement {
    actions = ["s3:Get*"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.import.bucket}/*"]
  }
}

resource "aws_iam_role" "import" {
  name = "bedrock-dynamodb-import-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy" "lambda_permissions" {
  role = "${aws_iam_role.import.id}"
  policy = "${data.aws_iam_policy_document.lambda_permissions.json}"
}

resource "aws_lambda_function" "csv_import" {
  filename = "${data.archive_file.import.output_path}"
  function_name = "DynamoDBImportCsv"
  handler = "DynamoDBImportCsv.lambda_handler"
  role = "${aws_iam_role.import.arn}"
  runtime = "python3.6"
  source_code_hash = "${data.archive_file.import.output_base64sha256}"
  timeout = "${var.import_timeout}"
  environment {
    variables {
      DataTypes = "${jsonencode(var.data_types)}"
      TableName = "${var.table_name}"
    }
  }
}

resource "aws_cloudwatch_log_group" "csv_import" {
  name = "/aws/lambda/${aws_lambda_function.csv_import.function_name}"
  retention_in_days = 30
}

resource "aws_s3_bucket" "import" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
  acl = "private"
  lifecycle_rule {
    enabled = true
    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket_notification" "import" {
  bucket = "${aws_s3_bucket.import.id}"
  lambda_function {
    lambda_function_arn = "${aws_lambda_function.csv_import.arn}"
    events = ["s3:ObjectCreated:*"]
    filter_suffix = ".csv"
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id = "AllowExecutionFromS3Bucket"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.csv_import.function_name}"
  principal = "s3.amazonaws.com"
  source_arn = "${aws_s3_bucket.import.arn}"
}
