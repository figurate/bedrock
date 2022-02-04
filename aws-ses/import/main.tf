data "aws_caller_identity" "current" {}

data "archive_file" "import" {
  output_path = "mailbox_import.zip"
  type = "zip"
  source_dir = "${var.lambda_path}"
}

data "aws_iam_role" "import" {
  name = "bedrock-mailbox-import-role"
}

resource "aws_lambda_function" "csv_import" {
  filename = "${data.archive_file.import.output_path}"
  function_name = "${var.function_name}"
  handler = "MailboxImportCsv.lambda_handler"
  role = "${data.aws_iam_role.import.arn}"
  runtime = "python3.6"
  source_code_hash = "${data.archive_file.import.output_base64sha256}"
  timeout = "${var.import_timeout}"
  environment {
    variables {
    }
  }
}

resource "aws_cloudwatch_log_group" "csv_import" {
  name = "lambda/${aws_lambda_function.csv_import.function_name}"
  retention_in_days = 30
}
