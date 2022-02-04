variable "bucket_name" {
  description = "Name of the source S3 bucket"
}

variable "topic_name" {
  description = "Name of the SNS topic to publish bucket changes"
}

variable "trigger_events" {
  description = "A list of bucket events that trigger the function"
  type        = "list"
  default     = ["s3:ObjectCreated:*"]
}

variable "filter_suffix" {
  description = "A suffix filter that identifies bucket objects that can trigger the function"
}
