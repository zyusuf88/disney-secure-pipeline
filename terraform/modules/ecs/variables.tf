
# variable "certificate_arn" {
#   description = "The ARN of the ACM certificate"
#   type        = string
# }

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

# variable "task_role_arn" {
#   description = "ARN of the ECS task role"
#   type        = string
# }

variable "security_group_id" {
  description = "Security group for ECS service"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs for ALB and ECS"
  type        = list(string)
}


variable "domain_name" {
  default = "tm.yzeynab.com"
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

# variable "alb_dns_name" {
#   description = "DNS name of the ALB"
#   type        = string
# }

variable "deployment_controller_type" {
  type        = string
  description = "Deployment controller type for ECS service (e.g., ECS)"
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

# variable "alb_listener" {
#   description = "ALB HTTPS listener"
#   type        = any
# }

variable "http_listener_arn" {
  description = "ARN of the HTTP listener"
  type        = string
}

variable "https_listener_arn" {
  description = "ARN of the HTTPS listener"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
}

variable "desired_count" {
  type        = number
  description = "Number of ECS tasks to run"
}

variable "launch_type" {
  type        = string
  description = "Launch type for ECS service (e.g., FARGATE)"
}

variable "assign_public_ip" {
  type        = bool
  description = "Whether to assign a public IP to the ECS task ENI"
}

variable "container_insights" {
  type        = string
 
}


variable "network_mode" {
  type        = string
  description = "ECS network mode (e.g., awsvpc, bridge)"
}

variable "requires_compatibilities" {
  type        = list(string)
  description = "ECS launch type (e.g., [\"FARGATE\"])"
}

variable "task_role_arn" {
  type        = string
  description = "IAM Task Role ARN for ECS task permissions"
}



variable "task_cpu" {
  type        = number
  description = "CPU units for ECS task"
}

variable "task_memory" {
  type        = number
  description = "Memory in MB for ECS task"
}


variable "container_name" {
  type        = string
  description = "Name of the container inside the task definition"
}

variable "container_image" {
  type        = string
  description = "ECR image URL for the container"
}

variable "container_cpu" {
  type        = number
  description = "CPU units for the container"
}

variable "container_memory" {
  type        = number
  description = "Memory in MB for the container"
}

variable "container_memory_reservation" {
  type        = number
  description = "Soft memory reservation for the container"
}

variable "container_essential" {
  type        = bool
  description = "Mark container as essential for the task"
}

variable "container_port_name" {
  type        = string
  description = "Port mapping name for the container"
}

variable "container_port" {
  type        = number
  description = "Container listening port"
}

variable "container_host_port" {
  type        = number
  description = "Host port mapping for the container"
}

variable "container_protocol" {
  type        = string
  description = "Protocol for container port mapping (e.g., tcp)"
}

variable "container_app_protocol" {
  type        = string
  description = "App protocol for container (e.g., http)"
}

variable "cpu_architecture" {
  type        = string
  description = "CPU architecture for ECS task (e.g., X86_64, ARM64)"
}

variable "operating_system_family" {
  type        = string
  description = "Operating system family (e.g., LINUX, WINDOWS_SERVER_2019_FULL)"
}