variable "backend_type" {
  description = "Type of Terraform backend to provision"
  default     = "s3"
}

variable "name" {
  description = "Name of the organization"
  default     = null
}

variable "admin" {
  description = "Email address of the organization admin"
  default     = null
}

variable "membership" {
  description = "A list of organization team member email addresses"
  type        = list(string)
  default     = []
}

variable "mfa_delete" {
  description = "Enable MFA delete for versioned objects"
  default     = false
}
