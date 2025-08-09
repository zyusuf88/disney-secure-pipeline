variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}


variable "record_name" {
  description = "The subdomain or record name (e.g., tm)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "az_1" {
  description = "Availability Zone for first public subnet"
  type        = string
}

variable "az_2" {
  description = "Availability Zone for second public subnet"
  type        = string
}

variable "region" {
  type = string
}

variable "public_subnet_1" {
  description = "CIDR block for first public subnet"
  type        = string
}

variable "public_subnet_2" {
  description = "CIDR block for second public subnet"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the services"
  type        = list(string)
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "container_image" {
  type = string
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


# variable "subnet_ids" {
#   description = "List of public subnet IDs for ALB and ECS"
#   type        = list(string)
# }

# variable "alb_dns_name" {
#   description = "DNS name of the ALB"
#   type        = string
# }

variable "deployment_controller_type" {
  description = "Deployment controller type for ECS service (e.g., ECS)"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
}

variable "launch_type" {
  description = "Launch type for ECS service (e.g., FARGATE)"
  type        = string
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the ECS task ENI"
  type        = bool
}

variable "container_insights" {
  description = "Enable or disable ECS Container Insights (enabled|disabled)"
  type        = string
}

variable "network_mode" {
  description = "ECS network mode (e.g., awsvpc, bridge)"
  type        = string
}

variable "requires_compatibilities" {
  description = "ECS launch type list (e.g., [\"FARGATE\"])"
  type        = list(string)
}

# variable "task_role_arn" {
#   description = "IAM Task Role ARN for ECS task permissions"
#   type        = string
# }

variable "task_cpu" {
  description = "CPU units for ECS task"
  type        = number
}

variable "task_memory" {
  description = "Memory in MB for ECS task"
  type        = number
}

variable "container_name" {
  description = "Name of the container inside the task definition"
  type        = string
}

variable "container_cpu" {
  description = "CPU units for the container"
  type        = number
}

variable "container_memory" {
  description = "Memory in MB for the container"
  type        = number
}

variable "container_memory_reservation" {
  description = "Soft memory reservation for the container"
  type        = number
}

variable "container_essential" {
  description = "Mark container as essential for the task"
  type        = bool
}

variable "container_port_name" {
  description = "Port mapping name for the container"
  type        = string
}

variable "container_port" {
  description = "Container listening port"
  type        = number
}

variable "container_host_port" {
  description = "Host port mapping for the container"
  type        = number
}

variable "container_protocol" {
  description = "Protocol for container port mapping (e.g., tcp)"
  type        = string
}

variable "container_app_protocol" {
  description = "App protocol for container (e.g., http)"
  type        = string
}

variable "cpu_architecture" {
  description = "CPU architecture for ECS task (e.g., X86_64, ARM64)"
  type        = string
}

variable "operating_system_family" {
  description = "Operating system family (e.g., LINUX, WINDOWS_SERVER_2019_FULL)"
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

variable "type" {
  description = "DNS record type for the Route 53 record "
  type        = string
}

variable "ttl" {
  description = "Time-to-live (TTL) for the DNS record "
  type        = number

}

# variable "public_subnet_ids" {
#   description = "List of subnet IDs for ALB deployment."
#   type        = list(string)
# }

# variable "security_group_id" {
#   description = "Security group ID to associate with the ALB."
#   type        = string
# }

# variable "certificate_arn" {
#   description = "ARN of the ACM SSL/TLS certificate for the HTTPS listener."
#   type        = string
# }

variable "alb_internal" {
  description = "Boolean to indicate whether the ALB is internal or internet-facing."
  type        = bool
}

variable "load_balancer_type" {
  description = "Type of load balancer (application or network)."
  type        = string
}

variable "drop_invalid_header_fields" {
  description = "Indicates whether to drop invalid HTTP headers at the ALB."
  type        = bool
}

variable "enable_deletion_protection" {
  description = "Indicates whether deletion protection is enabled for the ALB."
  type        = bool
}


variable "access_logs_enabled" {
  description = "Boolean to enable or disable ALB access logging."
  type        = bool
}

variable "target_group_port" {
  description = "Port on which the target group receives traffic."
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol used by the target group (HTTP or HTTPS)."
  type        = string
}

variable "target_type" {
  description = "Type of targets registered with the target group (e.g., ip or instance)."
  type        = string
}

variable "deregistration_delay" {
  description = "Time in seconds for deregistration delay of targets."
  type        = number
}

variable "slow_start" {
  description = "Time in seconds for the slow start mode of the target group."
  type        = number
}

variable "health_check_enabled" {
  description = "Whether health checks are enabled for the target group."
  type        = bool
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive successful health checks before a target is considered healthy."
  type        = number
}

variable "health_check_interval" {
  description = "Time in seconds between health checks."
  type        = number
}

variable "health_check_matcher" {
  description = "HTTP response code(s) to indicate a healthy target."
  type        = string
}

variable "health_check_path" {
  description = "Path used by the health check request."
  type        = string
}

variable "health_check_port" {
  description = "Port used for health check requests."
  type        = number
}

variable "health_check_protocol" {
  description = "Protocol used for health checks (HTTP or HTTPS)."
  type        = string
}

variable "health_check_timeout" {
  description = "Time in seconds before a health check request times out."
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive failed health checks before a target is considered unhealthy."
  type        = number
}

variable "http_listener_port" {
  description = "Port for the HTTP listener (typically 80)."
  type        = number
}

variable "http_listener_protocol" {
  description = "Protocol for the HTTP listener (typically HTTP)."
  type        = string
}

variable "https_listener_port" {
  description = "Port for the HTTPS listener (typically 443)."
  type        = number
}

variable "https_listener_protocol" {
  description = "Protocol for the HTTPS listener (typically HTTPS)."
  type        = string
}

variable "ssl_policy" {
  description = "SSL policy for the HTTPS listener."
  type        = string
}

variable "http_redirect_action_type" {
  description = "Default action type for HTTP listener (typically 'redirect')."
  type        = string
}

variable "http_redirect_protocol" {
  description = "Protocol to redirect HTTP traffic to (e.g., HTTPS)."
  type        = string
}


variable "http_redirect_status_code" {
  description = "HTTP status code used for the redirect action (e.g., HTTP_301 or HTTP_302)."
  type        = string
}


variable "force_destroy" {
  description = "Whether to allow the S3 bucket to be forcibly destroyed even if it contains objects."
  type        = bool
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore all public ACLs on this bucket."
  type        = bool
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket access for this bucket."
  type        = bool
}

variable "waf_scope" {
  description = "Scope of the WAF (REGIONAL for ALB, CLOUDFRONT for global)."
  type        = string
}


variable "waf_rules" {
  description = "List of managed rule groups to associate with the WAF."
  type = list(object({
    name                       = string
    priority                   = number
    override_action            = string
    managed_rule_group_name    = string
    vendor_name                = string
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  }))
}

variable "waf_visibility_config" {
  description = "Visibility config for WAF metrics and sampled requests."
  type = object({
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  })
}

variable "default_route" {
  description = "Default route CIDR for public route table"
  type        = string
}


variable "elb_log_delivery_account" {
  description = "AWS ELB log delivery account ID for the region"
  type        = string
}
