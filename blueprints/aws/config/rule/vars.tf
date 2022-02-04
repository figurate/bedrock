variable "rule_ids" {
  type        = "list"
  description = "A list of identifers for AWS-managed rules, e.g. _S3_BUCKET_PUBLIC_WRITE_PROHIBITED_"
  default     = []
}
