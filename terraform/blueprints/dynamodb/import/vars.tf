variable "lambda_path" {
  description = "The root path to lambda function source"
  default = "lambda"
}

variable "bucket_name" {
  description = "The suffix of the S3 bucket used to import data"
}

variable "data_types" {
  description = "A map of column names with applicable DynamoDB data type"
  type = "map"
  default = {}
}

variable "table_name" {
  description = "The name of the DynamoDB table to import into"
}

variable "import_timeout" {
  description = "The maximum time (seconds) to allow the import job to execute"
  default = "30"
}
