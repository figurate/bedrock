variable "lambda_path" {
  description = "The root path to lambda function source"
  default = "lambda"
}

variable "key_max_age" {
  description = "The maximum age (in days) of an IAM access key before it is disabled."
  default = 90
}
