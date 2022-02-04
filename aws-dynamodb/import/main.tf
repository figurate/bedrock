/**
 * # DynamoDB Batch Import
 *
 * Support processing of data files of various formats (e.g. CSV) to populate a DynamoDB table.
 */
data "aws_caller_identity" "current" {}

data "archive_file" "import" {
  output_path = "dynamodb_import.zip"
  type        = "zip"
  source_dir  = "${var.lambda_path}"
}

data "aws_iam_role" "import" {
  name = "bedrock-dynamodb-import-role"
}

resource "aws_lambda_function" "csv_import" {
  filename         = "${data.archive_file.import.output_path}"
  function_name    = "${var.function_name}"
  handler          = "DynamoDBImportCsv.lambda_handler"
  role             = "${data.aws_iam_role.import.arn}"
  runtime          = "python3.6"
  source_code_hash = "${data.archive_file.import.output_base64sha256}"
  timeout          = "${var.import_timeout}"
  environment {
    variables {
      DataTypes       = "${jsonencode(var.data_types)}"
      TableName       = "${var.table_name}"
      ItemTemplate    = "${jsonencode(var.item_template)}"
      AutoGenerateKey = "${var.auto_generate_key}"
    }
  }
}

resource "aws_cloudwatch_log_group" "csv_import" {
  name              = "/aws/lambda/${aws_lambda_function.csv_import.function_name}"
  retention_in_days = 30
}
