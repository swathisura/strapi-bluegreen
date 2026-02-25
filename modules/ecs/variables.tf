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

variable "alb_sg_id" {
  description = "ALB security group ID"
  type        = string
}

variable "blue_tg_arn" {
  description = "Blue target group ARN"
  type        = string
}

variable "http_listener_arn" {
  description = "HTTP listener ARN"
  type        = string
}

variable "execution_role_arn" {
  description = "ECS task execution role ARN"
  type        = string
}

variable "ecr_image_url" {
  description = "ECR image URL"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
  default     = "strapi"
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 1337
}

variable "task_cpu" {
  description = "Task CPU units"
  type        = string
  default     = "512"
}

variable "task_memory" {
  description = "Task memory in MB"
  type        = string
  default     = "1024"
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}