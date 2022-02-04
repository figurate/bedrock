variable "lambda_path" {
  description = "The root path to lambda function source"
  default = "lambda"
}

variable "function_name" {
  description = "A unique name used to reference the function"
}

variable "bucket_name" {
  description = "Name of the target S3 bucket"
}
