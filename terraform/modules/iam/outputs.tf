
output "task_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of the IAM task role for ECS tasks"
}

output "execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of the IAM execution role for ECS tasks"
}
