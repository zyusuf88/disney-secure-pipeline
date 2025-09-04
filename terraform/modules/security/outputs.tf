output "sg_alb_id" {
  value       = aws_security_group.alb.id
  description = "ALB Security Group ID"
}

output "sg_ecs_id" {
  value       = aws_security_group.ecs.id
  description = "ECS Security Group ID"
}
