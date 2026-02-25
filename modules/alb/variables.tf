variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 1337
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}