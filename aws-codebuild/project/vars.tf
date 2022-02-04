variable "codebuild_image" {
  description = "Docker image used to run build specs"
  default = "hashicorp/terraform:0.11.14"
}

variable "build_type" {
  description = "Indicates the buildspec to use for the build job"
  default = "blueprint"
}

variable "build_timeout" {
  description = "Maximum build time in minutes"
  default = "5"
}

variable "codecommit_repo" {
  description = "The source repository for the codebuild specification"
}
