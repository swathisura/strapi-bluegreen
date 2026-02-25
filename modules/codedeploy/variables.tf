variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "codedeploy_role_arn" {
  description = "CodeDeploy IAM role ARN"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
}

variable "http_listener_arn" {
  description = "Production listener ARN"
  type        = string
}

variable "test_listener_arn" {
  description = "Test listener ARN"
  type        = string
}

variable "blue_tg_name" {
  description = "Blue target group name"
  type        = string
}

variable "green_tg_name" {
  description = "Green target group name"
  type        = string
}

variable "deployment_config" {
  description = "CodeDeploy deployment config"
  type        = string
  default     = "CodeDeployDefault.ECSCanary10Percent5Minutes"
}

variable "termination_wait_minutes" {
  description = "Minutes to wait before terminating blue tasks"
  type        = number
  default     = 5
}