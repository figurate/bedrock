/**
 * # AWS Lambda function configuration
 *
 * Deploy a lambda function.
 */
data "archive_file" "cloudfront_rewrite" {
  output_path = "cloudfront_rewrite.zip"
  type = "zip"
  source_dir = "${format("%s", var.lambda_path)}"
}

data "aws_iam_role" "cloudfront_rewrite" {
  name = "bedrock-cloudfront-rewrite-role"
}

resource "aws_lambda_function" "cloudfront_rewrite" {
  function_name = "CloudFrontRewrite"
  handler = "CloudFrontRewrite.handler"
  filename = "${data.archive_file.cloudfront_rewrite.output_path}"
  role = "${data.aws_iam_role.cloudfront_rewrite.arn}"
  runtime = "nodejs8.10"
  source_code_hash = "${data.archive_file.cloudfront_rewrite.output_base64sha256}"
}

resource "aws_cloudwatch_log_group" "cloudfront_rewrite" {
  name = "/aws/lambda/${aws_lambda_function.cloudfront_rewrite.function_name}"
  retention_in_days = 30
}
