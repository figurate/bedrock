/**
 * # EC2 Instance Cycling
 *
 * A Lambda function to support power cycling EC2 instances.
 */
data "archive_file" "ec2_cycle" {
  output_path = "ec2_cycle.zip"
  type        = "zip"
  source_dir  = "${format("%s", var.lambda_path)}"
}

data "aws_iam_role" "ec2_cycle" {
  name = "bedrock-ec2-cycle-role"
}

resource "aws_lambda_function" "ec2_cycle" {
  function_name    = "Ec2CycleInstance"
  handler          = "Ec2CycleInstance.lambda_handler"
  filename         = "${data.archive_file.ec2_cycle.output_path}"
  role             = "${data.aws_iam_role.ec2_cycle.arn}"
  runtime          = "python3.6"
  source_code_hash = "${data.archive_file.ec2_cycle.output_base64sha256}"
}

resource "aws_cloudwatch_log_group" "ec2_cycle" {
  name              = "/aws/lambda/${aws_lambda_function.ec2_cycle.function_name}"
  retention_in_days = 30
}
