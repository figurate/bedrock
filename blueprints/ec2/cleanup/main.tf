/**
 * # EC2 Image Cleanup
 *
 * A Lambda function to support removal of stale EC2 Images (AMIs).
 */
data "archive_file" "ec2_cleanup" {
  output_path = "ec2_cleanup.zip"
  type = "zip"
  source_dir = "${format("%s", var.lambda_path)}"
}

data "aws_iam_role" "ec2_cleanup" {
  name = "bedrock-ec2-cleanup-role"
}

resource "aws_lambda_function" "ec2_cleanup" {
  function_name = "Ec2CleanupAMIs"
  handler = "Ec2CleanupAMIs.lambda_handler"
  filename = "${data.archive_file.ec2_cleanup.output_path}"
  role = "${data.aws_iam_role.ec2_cleanup.arn}"
  runtime = "python3.6"
  source_code_hash = "${data.archive_file.ec2_cleanup.output_base64sha256}"
}

resource "aws_cloudwatch_log_group" "ec2_cleanup" {
  name = "/aws/lambda/${aws_lambda_function.ec2_cleanup.function_name}"
  retention_in_days = 30
}
