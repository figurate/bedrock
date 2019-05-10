/**
 * # AWS Config Rule configuration
 *
 * Provision a Config Rule.
 */
resource "aws_config_config_rule" "config_rule" {
  count = "${length(var.rule_ids)}"
  name = "global-rule-${count.index}"
  "source" {
    owner = "AWS"
    source_identifier = "${element(var.rule_ids, count.index)}"
  }
}
