variable "repository_name" {
  description = "Name of the Docker repository (image)"
}

variable "scan_on_push" {
  description = "Automatically scan pushed images for vulnerabilities"
  default     = true
}

variable "image_expiry" {
  description = "Number of days before untagged images expire"
  default     = 7
}

//variable "import_enabled" {
//  description = "Automatic import of images from an external source"
//  default = false
//}

variable "source_registry" {
  description = "The source registry for importing images (note this should include the trailing forward slash (/))"
  default     = ""
}

variable "source_tags" {
  description = "A list of tags for image import from external registry"
  type        = list(string)
  default     = ["latest"]
}
