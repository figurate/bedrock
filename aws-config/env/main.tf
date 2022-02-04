/**
 * # AWS Config Rule configuration
 *
 * Provision a Config Rule.
 */
resource "aws_cloudformation_stack" "config_rule" {
  count = "${length(var.rule_ids)}"
  name = "${var.environment}-config_rule-${count.index}"
  parameters {
    Environment = "${var.environment}"
    ManagedRuleId = "${element(var.rule_ids, count.index)}"
  }
  template_body = "${file(format("%s/config-rule.yml", var.cloudformation_path))}"
}
