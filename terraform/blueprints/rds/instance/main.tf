resource "aws_cloudformation_stack" "rds_instance" {
  name = "${var.environment}-rds-instance"
  parameters {
    Environment = "${var.environment}"
  }
  template_body = "${file(format("%s/rds_instance.yml", var.cloudformation_path))}"
}
