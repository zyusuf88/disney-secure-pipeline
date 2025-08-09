variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

# variable "allowed_cidr_blocks" {
#   description = "List of CIDR blocks allowed to access the services"
#   type        = list(string)
# }


variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
}


variable "ingress_rules" {
  description = "ingress rules for security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

}
