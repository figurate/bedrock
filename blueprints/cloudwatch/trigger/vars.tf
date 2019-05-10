variable "trigger_name" {
  description = "Name of the trigger event rule"
}

variable "description" {
  description = "Description of the trigger event rule"
}

variable "trigger_schedule" {
  description = "CRON expression for trigger"
}

variable "function_name" {
  description = "Name of the Lambda function triggered by bucket changes"
}

variable "function_input" {
  description = "A map of values passed to the function invocation"
  type = "map"
  default = {}
}