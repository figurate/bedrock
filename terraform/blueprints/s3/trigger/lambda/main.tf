data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "source" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
}

data "aws_lambda_function" "trigger" {
  function_name = "${var.function_name}"
}

resource "aws_s3_bucket_notification" "trigger" {
  bucket = "${data.aws_s3_bucket.source.id}"
  lambda_function {
    lambda_function_arn = "${data.aws_lambda_function.trigger.arn}"
    events = "${var.trigger_events}"
    filter_suffix = "${var.filter_suffix}"
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id = "AllowExecutionFromS3Bucket"
  action = "lambda:InvokeFunction"
  function_name = "${data.aws_lambda_function.trigger.function_name}"
  principal = "s3.amazonaws.com"
  source_arn = "${data.aws_s3_bucket.source.arn}"
}
