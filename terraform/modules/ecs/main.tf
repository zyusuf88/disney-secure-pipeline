terraform {
  required_version = ">= 1.11.2, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-${var.environment}-cluster"

  setting {
    name  = "containerInsights"
    value = var.container_insights
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-cluster"
    environment = var.environment
  }
}


resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project_name}-${var.environment}-task"
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions = jsonencode([
    {
      name              = var.container_name
      image             = var.container_image
      cpu               = var.container_cpu
      memory            = var.container_memory
      memoryReservation = var.container_memory_reservation
      essential         = var.container_essential

      portMappings = [
        {
          name          = var.container_port_name
          containerPort = var.container_port
          hostPort      = var.container_host_port
          protocol      = var.container_protocol
          appProtocol   = var.container_app_protocol
        }
      ]
    }
  ])

  runtime_platform {
    cpu_architecture        = var.cpu_architecture
    operating_system_family = var.operating_system_family
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-task"
    environment = var.environment
  }
}

resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
  subnets          = var.private_subnet_ids
  security_groups  = [var.ecs_security_group_id]
  assign_public_ip = var.assign_public_ip
}

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  deployment_controller {
    type = var.deployment_controller_type
  }

  depends_on = [var.http_listener_arn, var.https_listener_arn]

  tags = {
    Name        = "${var.project_name}-${var.environment}-service"
    environment = var.environment
  }
}
