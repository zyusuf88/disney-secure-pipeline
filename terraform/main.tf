module "vpc" {
  source = "./modules/vpc"

  project_name            = var.project_name
  vpc_cidr                = var.vpc_cidr
  public_subnet_1         = var.public_subnet_1
  public_subnet_2         = var.public_subnet_2
  az_1                    = var.az_1
  az_2                    = var.az_2
  environment             = var.environment
  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_dns_support      = var.enable_dns_support
  map_public_ip_on_launch = var.map_public_ip_on_launch
  default_route           = var.default_route
}


module "security" {
  source = "./modules/security"

  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  ingress_rules       = var.ingress_rules
  egress_rules        = var.egress_rules

}


module "alb" {
  source                           = "./modules/alb"
  vpc_id                           = module.vpc.vpc_id
  security_group_id                = module.security.security_group_id
  certificate_arn                  = module.acm.certificate_arn
  project_name                     = var.project_name
  environment                      = var.environment
  subnet_ids                       = module.vpc.subnet_ids
  alb_internal                     = var.alb_internal
  load_balancer_type               = var.load_balancer_type
  drop_invalid_header_fields       = var.drop_invalid_header_fields
  enable_deletion_protection       = var.enable_deletion_protection
  access_logs_enabled              = var.access_logs_enabled
  target_group_port                = var.target_group_port
  target_group_protocol            = var.target_group_protocol
  target_type                      = var.target_type
  deregistration_delay             = var.deregistration_delay
  slow_start                       = var.slow_start
  health_check_enabled             = var.health_check_enabled
  health_check_healthy_threshold   = var.health_check_healthy_threshold
  health_check_interval            = var.health_check_interval
  health_check_matcher             = var.health_check_matcher
  health_check_path                = var.health_check_path
  health_check_port                = var.health_check_port
  health_check_protocol            = var.health_check_protocol
  health_check_timeout             = var.health_check_timeout
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
  http_listener_port               = var.http_listener_port
  http_listener_protocol           = var.http_listener_protocol
  https_listener_port              = var.https_listener_port
  https_listener_protocol          = var.https_listener_protocol
  ssl_policy                       = var.ssl_policy
  http_redirect_action_type        = var.http_redirect_action_type
  http_redirect_status_code        = var.http_redirect_status_code
  http_redirect_protocol           = var.http_redirect_protocol
  force_destroy                    = var.force_destroy
  block_public_acls                = var.block_public_acls
  block_public_policy              = var.block_public_policy
  ignore_public_acls               = var.ignore_public_acls
  restrict_public_buckets          = var.restrict_public_buckets
  waf_scope                        = var.waf_scope
  waf_rules                        = var.waf_rules
  waf_visibility_config            = var.waf_visibility_config
  elb_log_delivery_account         = var.elb_log_delivery_account

}


module "ecs" {
  source                       = "./modules/ecs"
  project_name                 = var.project_name
#  vpc_id                       = module.vpc.vpc_id
  environment                  = var.environment
  subnet_ids                   = module.vpc.subnet_ids
  security_group_id            = module.security.security_group_id
  http_listener_arn            = module.alb.http_listener_arn
  https_listener_arn           = module.alb.https_listener_arn
  target_group_arn             = module.alb.target_group_arn
  domain_name                  = var.domain_name
  execution_role_arn           = var.execution_role_arn
  container_image              = var.container_image
  deployment_controller_type   = var.deployment_controller_type
  desired_count                = var.desired_count
  launch_type                  = var.launch_type
  assign_public_ip             = var.assign_public_ip
  container_insights           = var.container_insights
  network_mode                 = var.network_mode
  requires_compatibilities     = var.requires_compatibilities
  task_role_arn                = module.iam.task_role_arn
  task_cpu                     = var.task_cpu
  task_memory                  = var.task_memory
  container_name               = var.container_name
  container_cpu                = var.container_cpu
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  container_essential          = var.container_essential
  container_port_name          = var.container_port_name
  container_port               = var.container_port
  container_host_port          = var.container_host_port
  container_protocol           = var.container_protocol
  container_app_protocol       = var.container_app_protocol
  cpu_architecture             = var.cpu_architecture
  operating_system_family      = var.operating_system_family

}


module "route53" {
  source          = "./modules/route53"
  domain_name     = var.domain_name
  record_name     = var.record_name
  alb_dns_name    = module.alb.alb_dns_name
  alb_zone_id     = module.alb.alb_zone_id
  certificate_arn = module.acm.certificate_arn
  ttl             = var.ttl
  type            = var.type
}


module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
  record_name = var.record_name

}

module "iam" {
  source                        = "./modules/iam"
  project_name                  = var.project_name
  environment                   = var.environment
  ecr_readonly_policy_arn       = var.ecr_readonly_policy_arn
  ecs_task_execution_policy_arn = var.ecs_task_execution_policy_arn
}
