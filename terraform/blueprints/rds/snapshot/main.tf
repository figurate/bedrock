data "archive_file" "rds_snapshot" {
  output_path = "rds_snapshot.zip"
  type = "zip"
  source_dir = "${format("%s", var.lambda_path)}"
}

data "aws_iam_role" "rds_snapshot" {
  name = "bedrock-rds-snapshot-role"
}

resource "aws_lambda_function" "rds_snapshot_instance" {
  function_name = "RdsSnapshotInstance"
  handler = "RdsSnapshotInstance.lambda_handler"
  role = "${data.aws_iam_role.rds_snapshot.arn}"
  runtime = "python3.6"
  source_code_hash = "${data.archive_file.rds_snapshot.output_base64sha256}"
}

resource "aws_cloudwatch_log_group" "rds_snapshot_instance" {
  name = "/aws/lambda/${aws_lambda_function.rds_snapshot_instance.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_function" "rds_snapshot_cluster" {
  function_name = "RdsSnapshotCluster"
  handler = "RdsSnapshotCluster.lambda_handler"
  role = "${data.aws_iam_role.rds_snapshot.arn}"
  runtime = "python3.7"
  source_code_hash = "${data.archive_file.rds_snapshot.output_base64sha256}"
}

resource "aws_cloudwatch_log_group" "rds_snapshot_cluster" {
  name = "/aws/lambda/${aws_lambda_function.rds_snapshot_cluster.function_name}"
  retention_in_days = 30
}
