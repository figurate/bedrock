variable "bucket_name" {
  description = "Name of S3 bucket"
}

variable "bucket_acl" {
  description = "Access control for bucket"
  default     = "private"
}

variable "version_enabled" {
  description = "Enable object versioning"
  default     = "true"
}

variable "object_expires" {
  description = "Number of days before object expiration"
  default     = "0"
}

variable "restrict_public_access" {
  description = "Indicates whether to block public access to this bucket"
  default     = "true"
}
