data "archive_file" "rds_cycle" {
  output_path = "rds_cycle.zip"
  type        = "zip"
  source_dir  = "${format("%s", var.lambda_path)}"
}

data "aws_iam_role" "rds_cycle" {
  name = "bedrock-rds-cycle-role"
}

resource "aws_lambda_function" "rds_cycle_instance" {
  function_name    = "RdsCycleInstance"
  handler          = "RdsCycleInstance.lambda_handler"
  filename         = "${data.archive_file.rds_cycle.output_path}"
  role             = "${data.aws_iam_role.rds_cycle.arn}"
  runtime          = "python3.6"
  source_code_hash = "${data.archive_file.rds_cycle.output_base64sha256}"
}

resource "aws_cloudwatch_log_group" "rds_cycle_instance" {
  name              = "/aws/lambda/${aws_lambda_function.rds_cycle_instance.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_function" "rds_cycle_cluster" {
  function_name    = "RdsCycleCluster"
  handler          = "RdsCycleCluster.lambda_handler"
  filename         = "${data.archive_file.rds_cycle.output_path}"
  role             = "${data.aws_iam_role.rds_cycle.arn}"
  runtime          = "python3.7"
  source_code_hash = "${data.archive_file.rds_cycle.output_base64sha256}"
}

resource "aws_cloudwatch_log_group" "rds_cycle_cluster" {
  name              = "/aws/lambda/${aws_lambda_function.rds_cycle_cluster.function_name}"
  retention_in_days = 30
}
