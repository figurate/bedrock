variable "bucket_name" {
  description = "Name of target S3 bucket"
}

variable "access_log_bucket" {
  description = "An S3 bucket used as a target for access logs"
  default = ""
}

variable "enabled" {
  description = "Indicates if distribution is enabled"
  default = false
}

variable "price_class" {
  description = "Specifies the edge locations based on price class"
  default = "PriceClass_100"
}

variable "default_root_object" {
  description = "The default page when accessing the root URL of the distribution"
  default = "index.html"
}

variable "aliases" {
  type = "list"
  description = "A list of associated domain names that reference the distribution"
  default = []
}

variable "hosted_zone" {
  description = "Route53 zone for alias domain names"
}

locals {
  origin_id = "S3-${var.bucket_name}"
}