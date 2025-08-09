variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_1" {
  description = "CIDR block for first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2" {
  description = "CIDR block for second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "az_1" {
  description = "Availability Zone for first public subnet"
  type        = string
}

variable "az_2" {
  description = "Availability Zone for second public subnet"
  type        = string
}


variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support for the VPC"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in the VPC"

}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Automatically assign public IPs on public subnets"
}


variable "default_route" {
  description = "Default route CIDR for public route table"
  type        = string
}


