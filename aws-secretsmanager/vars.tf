variable "secrets_admins" {
  description = "A list of users that can administer encrypted secrets"
  type = list(string)
  default = []
}

variable "secrets_users" {
  description = "A list of users that can access encrypted secrets"
  type = list(string)
  default = []
}

variable "capabilities" {
  description = "A list of capabilities enabled for the application environment"
  type = list(string)
  default = []
}
