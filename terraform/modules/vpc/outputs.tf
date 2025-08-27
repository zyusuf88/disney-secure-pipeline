output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID of the VPC"
}

# Public subnets (for ALB, NAT gateways, bastion if you add one later)
output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

# Private subnets (for ECS tasks, RDS, ElastiCache, etc.)
output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

# output "public_subnets" {
#   value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
#   description = "IDs of the public subnets"
# }

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "ID of the Internet Gateway"
}
