resource "aws_cloudformation_stack" "rds_aurora" {
  name = "${var.environment}-rds-cluster"
  parameters {
    Environment = "${var.environment}"
  }
  template_body = "${file(format("%s/rds_aurora.yml", var.cloudformation_path))}"
}
