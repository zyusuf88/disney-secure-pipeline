output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "alb_zone_id" {
  value       = aws_lb.this.zone_id
  description = "Route 53 hosted zone ID for the Application Load Balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "ARN of the target group for the Application Load Balancer"
}

output "http_listener_arn" {
  value       = aws_lb_listener.http_listener.arn
  description = "ARN of the HTTP listener for the Application Load Balancer"
}

output "https_listener_arn" {
  value       = aws_lb_listener.https_listener.arn
  description = "ARN of the HTTPS listener for the Application Load Balancer"
}

output "https_listener" {
  value       = aws_lb_listener.https_listener
  description = "The HTTPS listener resource for the Application Load Balancer"
}
