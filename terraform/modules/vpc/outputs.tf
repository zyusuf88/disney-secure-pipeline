output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID of the VPC"
}

output "subnet_ids" {
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  description = "IDs of the public subnets"
}

# output "public_subnets" {
#   value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
#   description = "IDs of the public subnets"
# }

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "ID of the Internet Gateway"
}
