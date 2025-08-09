variable "project_name" {
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
}


variable "ecr_readonly_policy_arn" {
  description = "IAM policy ARN for ECR read-only access"
  type        = string
}

variable "ecs_task_execution_policy_arn" {
  description = "IAM policy ARN for ECS Task Execution Role"
  type        = string
}