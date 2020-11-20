variable "vpc_default" {
  description = "Use the default VPC for private namespaces"
  default     = true
}

variable "vpc_tags" {
  type        = map(any)
  description = "Lookup tags to identify VPC for private namespaces"
  default     = {}
}
