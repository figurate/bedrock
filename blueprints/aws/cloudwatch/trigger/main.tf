data "aws_lambda_function" "trigger" {
  function_name = "${var.function_name}"
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = "${var.trigger_name}"
  description         = "${var.description}"
  schedule_expression = "${format("cron(%s)", var.trigger_schedule)}"
  role_arn            = ""
}

resource "aws_cloudwatch_event_target" "event_target" {
  arn   = data.aws_lambda_function.trigger.arn
  rule  = aws_cloudwatch_event_rule.event_rule.name
  input = jsonencode(var.function_input)
}

resource "aws_lambda_permission" "trigger" {
  statement_id  = "${var.trigger_name}"
  action        = "lambda:InvokeFunction"
  function_name = "${data.aws_lambda_function.trigger.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.event_rule.arn}"
}
