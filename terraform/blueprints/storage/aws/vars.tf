variable "bucket_name" {
  description = "Name of S3 bucket"
}

variable "version_enabled" {
  description = "Enable object versioning"
  default = "true"
}

variable "object_expires" {
  description = "Number of days before object expiration"
  default = "0"
}
