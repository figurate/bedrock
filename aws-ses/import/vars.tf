variable "lambda_path" {
  description = "The root path to lambda function source"
  default = "lambda"
}

variable "function_name" {
  description = "A unique name used to reference the function"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to import into"
}

variable "import_timeout" {
  description = "The maximum time (seconds) to allow the import job to execute"
  default = "30"
}
