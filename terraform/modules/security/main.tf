
# terraform {
#   required_version = ">= 1.6, < 2.0"
# }

# resource "aws_security_group" "this" {
#   name        = "${var.project_name}-${var.environment}-ec2-sg"
#   description = "Security group for application"
#   vpc_id      = var.vpc_id

#   dynamic "ingress" {
#     for_each = var.ingress_rules
#     content {
#       description = ingress.value.description
#       from_port   = ingress.value.from_port
#       to_port     = ingress.value.to_port
#       protocol    = ingress.value.protocol
#       cidr_blocks = ingress.value.cidr_blocks
#     }
#   }

#   dynamic "egress" {
#     for_each = var.egress_rules
#     content {
#       description = egress.value.description
#       from_port   = egress.value.from_port
#       to_port     = egress.value.to_port
#       protocol    = egress.value.protocol
#       cidr_blocks = egress.value.cidr_blocks
#     }
#   }
#   tags = {
#     Name = "${var.project_name}-${var.environment}-ec2-sg"
#   }
# }
#######################################
#######################################
#######################################



########################################
# modules/security/main.tf
# Two SGs using your naming & dynamic layout
# - ALB SG: rules from var.alb_ingress_rules (cidr-based)
# - ECS SG: NO world-open rules; app port allowed ONLY from ALB SG
########################################



terraform {
  required_version = ">= 1.11.2, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# ---------- ALB Security Group ----------
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Internet-facing ALB"
  vpc_id      = var.vpc_id

  # Ingress from tfvars (e.g., 80/443 from 0.0.0.0/0)
  dynamic "ingress" {
    for_each = var.alb_ingress_rules
    content {
      description = lookup(ingress.value, "description", null)
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [var.vpc_cidr]
    }
  }

  # Egress from tfvars (usually all)
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = lookup(egress.value, "description", null)
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [var.vpc_cidr]
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-alb-sg"
    environment = var.environment
  }
}

# ---------- ECS Tasks Security Group ----------
resource "aws_security_group" "ecs" {
  name        = "${var.project_name}-${var.environment}-ecs-sg"
  description = "ECS tasks (only app port from ALB)"
  vpc_id      = var.vpc_id

  # No cidr-based ingress rules here (keeps it locked down).
  # We add a separate, clear rule referencing the ALB SG below.

  # Egress from tfvars (usually all)
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = lookup(egress.value, "description", null)
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [var.vpc_cidr]
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ecs-sg"
    environment = var.environment
  }
}

# Allow ONLY the ALB SG to reach the ECS app port (from tfvars)
resource "aws_security_group_rule" "ecs_app_from_alb" {
  type                     = "ingress"
  security_group_id        = aws_security_group.ecs.id
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
  description              = "App port from ALB SG"
}
