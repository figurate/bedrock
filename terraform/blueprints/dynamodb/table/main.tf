/**
 * # DynamoDB Create Table
 *
 * Support creation of DynamoDB tables.
 */
resource "aws_dynamodb_table" "table" {
  name = "${var.db_table}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "${var.db_hash_key}"
  range_key = "${var.range_key}"
  attribute = "${var.db_attributes}"
}
