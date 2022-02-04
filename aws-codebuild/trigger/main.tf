/**
 * # AWS Lambda function configuration
 *
 * Deploy a lambda function.
 */
data "archive_file" "codebuild_trigger" {
  output_path = "codebuild_trigger.zip"
  type = "zip"
  source_dir = "${format("%s", var.lambda_path)}"
}

data "aws_iam_role" "codebuild_trigger" {
  name = "codebuild-trigger-role"
  path = "bedrock"
}

resource "aws_lambda_function" "codebuild_trigger" {
  function_name = "CodebuildTrigger"
  handler = "CodebuildTrigger.lambda_handler"
  filename = "${data.archive_file.codebuild_trigger.output_path}"
  role = "${data.aws_iam_role.codebuild_trigger.arn}"
  runtime = "python3.6"
  source_code_hash = "${data.archive_file.codebuild_trigger.output_base64sha256}"
}

resource "aws_cloudwatch_log_group" "codebuild_trigger" {
  name = "lambda/${aws_lambda_function.codebuild_trigger.function_name}"
  retention_in_days = 30
}
