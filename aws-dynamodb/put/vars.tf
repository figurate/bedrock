variable "lambda_path" {
  description = "The root path to lambda function source"
  default     = "lambda"
}

variable "function_name" {
  description = "A unique name used to reference the function"
}

variable "data_types" {
  description = "A map of column names with applicable DynamoDB data type"
  type        = "map"
  default     = {}
}

variable "table_name" {
  description = "The name of the DynamoDB table to put items into"
}

variable "put_item_timeout" {
  description = "The maximum time (seconds) to allow the put job to execute"
  default     = "30"
}
