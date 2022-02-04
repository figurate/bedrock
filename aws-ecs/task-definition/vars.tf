variable "name" {
  description = "Task definition name"
}

variable "image" {
  description = "ECR registry name"
}

variable "namespace" {
  description = "Provides a context for the intended deployment of the Task Definition (e.g. environment, etc.)"
  default     = null
}

variable "image_tag" {
  description = "Docker image tag for ECS service"
  default     = "latest"
}

variable "cpu" {
  description = "Required vCPU units for the service"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Required memory for the service"
  type        = number
  default     = 256
}

variable "ports" {
  description = "A list of port mappings to publish"
  type        = list(tuple([number, number]))
  default     = []
}

variable "network_mode" {
  description = "Network mode for service containers (available options: `bridge`, `host`, `awsvpc`)"
  default     = "bridge"
}

variable "volumes" {
  description = "A list of volume names and host paths to mount on the container"
  type        = list(tuple([string, string]))
  default     = []
}

variable "mounts" {
  description = "A list of volume ids and mount paths for the container"
  type        = list(tuple([string, string, bool]))
  default     = []
}

variable "task_environment" {
  description = "A map of environment variables configured on the primary container"
  type        = map(string)
  default = {
    NGINX_ENVSUBST_TEMPLATE_DIR = "/opt/nginx/templates"
  }
}

variable "docker_labels" {
  description = "A map of docker labels to attach to the container definition"
  type        = map(any)
  default     = {}
}

variable "health_check" {
  description = "The command, interval, timeout and number of retries for health check of the primary container"
  type        = tuple([list(string), number, number, number])
  default     = null
}