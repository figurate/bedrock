variable "droplets" {
  description = "A list of droplet configs"
  type        = list(tuple([string, string, string]))
  default     = []
}
