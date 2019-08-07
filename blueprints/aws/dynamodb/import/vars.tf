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
  description = "The name of the DynamoDB table to import into"
}

variable "item_template" {
  description = "A template map used to initialise each item"
  type        = "map"
  default     = {}
}

variable "auto_generate_key" {
  description = "Indicates whether the import function should automatically generate a unique partition key"
  default     = true
}

variable "import_timeout" {
  description = "The maximum time (seconds) to allow the import job to execute"
  default     = "30"
}
