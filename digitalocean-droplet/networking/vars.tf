variable "firewalls" {
  description = "A list of firewall rule configs"
  type = list(tuple([string, list(string), list(string)]))
  default = []
}
