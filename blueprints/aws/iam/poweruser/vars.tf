variable "username" {
  description = "The username of the Bedrock power user"
}

variable "iam_groups" {
  description = "A list of IAM groups the user belongs to."
  type        = "list"
  default     = ["iam-keyrotation"]
}
