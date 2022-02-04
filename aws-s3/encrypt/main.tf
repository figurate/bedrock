/**
 * # AWS Lambda function configuration
 *
 * Deploy a lambda function.
 */
data "aws_caller_identity" "current" {}

data "archive_file" "s3_encrypt" {
  output_path = "s3_encrypt.zip"
  type = "zip"
  source_dir = "${format("%s", var.lambda_path)}"
}

data "aws_iam_role" "s3_encrypt" {
  name = "bedrock-s3-encrypt-role"
}

data "aws_s3_bucket" "target" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
}

resource "aws_lambda_function" "s3_encrypt" {
  function_name = "${var.function_name}"
  handler = "S3EncryptFile.lambda_handler"
  filename = "${data.archive_file.s3_encrypt.output_path}"
  role = "${data.aws_iam_role.s3_encrypt.arn}"
  runtime = "python3.6"
  source_code_hash = "${data.archive_file.s3_encrypt.output_base64sha256}"
  environment {
    variables {
      S3Bucket = "${data.aws_s3_bucket.target.bucket}"
    }
  }
}

resource "aws_cloudwatch_log_group" "s3_encrypt" {
  name = "lambda/${aws_lambda_function.s3_encrypt.function_name}"
  retention_in_days = 30
}
