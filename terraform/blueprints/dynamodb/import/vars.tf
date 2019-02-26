variable "lambda_path" {
  description = "The root path to lambda function source"
  default = "lambda"
}

variable "bucket_name" {
  description = "The suffix of the S3 bucket used to import data"
}
