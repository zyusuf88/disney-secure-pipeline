output "ecs_execution_role_arn" {
  value = var.execution_role_arn
  description = "ARN of the ECS task execution role"
}

# output "sg_ecs_id" {
#   description = "Security Group ID for ECS tasks/services"
#   value       = aws_security_group.ecs.id
# }
