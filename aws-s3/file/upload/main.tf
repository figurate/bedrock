/**
 * # AWS Lambda function configuration
 *
 * Deploy a lambda function.
 */
data "aws_caller_identity" "current" {}

data "archive_file" "s3_upload" {
  output_path = "s3_upload.zip"
  type = "zip"
  source_dir = format("%s", var.lambda_path)
}

data "aws_iam_role" "s3_upload" {
  name = "bedrock-s3-upload-role"
}

data "aws_s3_bucket" "target" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
}

resource "aws_lambda_function" "s3_upload" {
  function_name = var.function_name
  handler = "S3UploadFile.lambda_handler"
  filename = data.archive_file.s3_upload.output_path
  role = data.aws_iam_role.s3_upload.arn
  runtime = "python3.6"
  source_code_hash = data.archive_file.s3_upload.output_base64sha256
  environment {
    variables {
      S3Bucket = data.aws_s3_bucket.target.bucket
    }
  }
}

resource "aws_cloudwatch_log_group" "s3_upload" {
  name = "lambda/${aws_lambda_function.s3_upload.function_name}"
  retention_in_days = 30
}
