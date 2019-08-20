variable "volume_name" {
  description = "The name of the block storage volume"
}

variable "volume_size" {
  description = "The size of the block storage volume (GiB)"
  default     = 10
}

variable "volume_label" {
  description = "Label applied to the volume"
  default     = ""
}

variable "volume_type" {
  description = "Formatting applied to the volume"
  default     = "ext4"
}

variable "volume_count" {
  description = "Support for creating multiple volumes"
  default     = 1
}

variable "environment" {
  description = "Environment identifier for the volume"
}

variable "do_region" {
  description = "The region to create volume in"
}
