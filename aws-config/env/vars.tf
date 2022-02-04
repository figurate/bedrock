variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default = "cloudformation"
}

variable "rule_ids" {
  type = list(string)
  description = "A list of identifers for AWS-managed rules, e.g. _EC2_INSTANCE_MANAGED_BY_SSM_"
  default = []
}
