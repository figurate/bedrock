variable "repository_name" {
  description = "Name of the Docker repository (image)"
}

variable "image_expiry" {
  description = "Number of days before untagged images expire"
  default     = 7
}
