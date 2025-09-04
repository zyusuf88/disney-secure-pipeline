variable "project_name" {
  description = "Project name prefix used for naming ALB resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB and target group will be deployed."
  type        = string
}

variable "public_subnet_ids" {
  description = "PUBLIC subnet IDs for the internet-facing ALB (>=2)"
  type        = list(string)
}


variable "security_groups" {
  description = "Security groups to attach to the ALB"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the ACM SSL/TLS certificate for the HTTPS listener."
  type        = string
}

variable "alb_internal" {
  description = "Boolean to indicate whether the ALB is internal or internet-facing."
  type        = bool
}

variable "load_balancer_type" {
  description = "Type of load balancer."
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

variable "https_listener_port" {
  description = "Port for the HTTPS listener "
  type        = number
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


variable "elb_log_delivery_account" {
  description = "AWS ELB log delivery account ID for the region"
  type        = string
}
