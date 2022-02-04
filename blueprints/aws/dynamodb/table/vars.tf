variable "db_table" {
  description = "The name of the DynamoDB table to provision"
}

variable "db_hash_key" {
  description = "The primary key column in the table"
}

variable "range_key" {
  description = "The sort key column in the table"
}

variable "db_attributes" {
  description = "A list of attributes (columns) in the table"
  type        = "list"
}
