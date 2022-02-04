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

variable "access_log_bucket" {
  description = "An S3 bucket used as a target for access logs"
}

variable "restrict_public_access" {
  description = "Indicates whether to block public access to this bucket"
  default = "true"
}

variable "content_path" {
  description = "Root path of local content"
  default = "."
}

variable "includes" {
  description = "A list of include filters to apply"
  type = list(string)
  default = []
}

variable "excludes" {
  description = "A list of exclude filters to apply"
  type = list(string)
  default = ["*"]
}

variable "delete" {
  description = "Remove files from the destination that don't exist in the source"
  default = "false"
}

locals {
  excludes_string = "--exclude \"${join("\" --exclude \"", var.excludes)}\""
  includes_string = "--include \"${join("\" --include \"", var.includes)}\""
}
