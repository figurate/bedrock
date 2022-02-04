variable "name" {
  description = "Name of the organization"
}

variable "admin" {
  description = "Email address of the organization admin"
}

variable "membership" {
  description = "A list of organization team member email addresses"
  type        = list(string)
  default     = []
}
