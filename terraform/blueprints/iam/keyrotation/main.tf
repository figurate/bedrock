/**
 * # AWS Lambda function configuration
 *
 * Deploy a lambda function.
 */
data "archive_file" "iam_keyrotation" {
  output_path = "iam_keyrotation.zip"
  type = "zip"
  source_dir = "${format("%s", var.lambda_path)}"
}

data "aws_iam_role" "iam_keyrotation" {
  name = "bedrock-iam-keyrotation-role"
}

resource "aws_lambda_function" "iam_keyrotation" {
  function_name = "IamKeyRotation"
  handler = "IamKeyRotation.lambda_handler"
  filename = "${data.archive_file.iam_keyrotation.output_path}"
  role = "${data.aws_iam_role.iam_keyrotation.arn}"
  runtime = "python3.6"
  source_code_hash = "${data.archive_file.iam_keyrotation.output_base64sha256}"
  environment {
    variables {
      KeyMaxAge = "${var.key_max_age}"
    }
  }
}

resource "aws_cloudwatch_log_group" "iam_keyrotation" {
  name = "/aws/lambda/${aws_lambda_function.iam_keyrotation.function_name}"
  retention_in_days = 30
}

resource "aws_iam_group" "iam_keyrotation" {
  name = "iam-keyrotation"
}
