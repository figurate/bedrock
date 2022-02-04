resource "aws_cloudwatch_log_group" "log" {
  name              = "cloudtrail"
  retention_in_days = var.log_retention_in_days
}

module "alarms" {
  source = "nozaq/secure-baseline/aws//modules/alarm-baseline"

  cloudtrail_log_group_name = aws_cloudwatch_log_group.log.name
}
