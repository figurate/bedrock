variable "organizations" {
  description = "A list of organization names and administrators"
  type        = list(tuple([string, string]))
  default     = []
}

variable "membership" {
  description = "A list of organization team members"
  type        = list(string)
  default     = []
}
