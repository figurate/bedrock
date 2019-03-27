/**
 * # AWS Lambda function configuration
 *
 * Deploy a lambda function.
 */
data "archive_file" "chime_notification" {
  output_path = "chime_notification.zip"
  type = "zip"
  source_dir = "${var.lambda_path}"
}

data "aws_iam_role" "chime_notification" {
  name = "bedrock-chime-notification-role"
}

resource "aws_lambda_function" "chime_notification" {
  function_name = "ChimeNotification"
  handler = "ChimeNotification.lambda_handler"
  filename = "${data.archive_file.chime_notification.output_path}"
  role = "${data.aws_iam_role.chime_notification.arn}"
  runtime = "python3.6"
  source_code_hash = "${data.archive_file.chime_notification.output_base64sha256}"
  layers = ["arn:aws:lambda:ap-southeast-2:976651329757:layer:python-requests:2"]
  environment {
    variables {
      WebhookUrl = "${var.webhook_url}"
    }
  }
}

resource "aws_cloudwatch_log_group" "chime_notification" {
  name = "/aws/lambda/${aws_lambda_function.chime_notification.function_name}"
  retention_in_days = 30
}
