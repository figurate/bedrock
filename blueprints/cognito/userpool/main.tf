resource "aws_cognito_user_pool" "pool" {
  name = "${var.pool_name}"
  alias_attributes = ["email"]
  mfa_configuration = "OPTIONAL"
  schema {
    attribute_data_type = "DateTime"
    name = "birthdate"
    required = true
  }
  schema {
    attribute_data_type = "String"
    name = "email"
    required = true
  }
}
