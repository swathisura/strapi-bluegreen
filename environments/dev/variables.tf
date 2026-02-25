variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
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