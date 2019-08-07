/**
 * # DynamoDB Put Item
 *
 * Support adding an item to a DynamoDB table from a JSON payload.
 */
data "aws_caller_identity" "current" {}

data "archive_file" "put" {
  output_path = "dynamodb_put.zip"
  type        = "zip"
  source_dir  = "${var.lambda_path}"
}

data "aws_iam_role" "put" {
  name = "bedrock-dynamodb-put-role"
}

resource "aws_lambda_function" "put_item" {
  filename         = "${data.archive_file.put.output_path}"
  function_name    = "${var.function_name}"
  handler          = "DynamoDBPutItem.lambda_handler"
  role             = "${data.aws_iam_role.put.arn}"
  runtime          = "python3.6"
  source_code_hash = "${data.archive_file.put.output_base64sha256}"
  timeout          = "${var.put_item_timeout}"
  environment {
    variables {
      DataTypes = "${jsonencode(var.data_types)}"
      TableName = "${var.table_name}"
    }
  }
}

resource "aws_cloudwatch_log_group" "put_item" {
  name              = "/aws/lambda/${aws_lambda_function.put_item.function_name}"
  retention_in_days = 30
}
