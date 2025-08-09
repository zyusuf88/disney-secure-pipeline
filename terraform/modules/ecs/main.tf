
# resource "aws_ecs_cluster" "threat_app_cluster" {
#   name = "threat-app-cluster"
#  #checkov requirement
#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }
# }

# resource "aws_ecs_task_definition" "this" {
#   family                   = "threat-app-td"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#  # task_role_arn       = var.task_role_arn
#   execution_role_arn  = var.execution_role_arn
#   cpu                     = 512
#   memory                  = 1024

#   container_definitions = jsonencode([
#     {
#       name                 = "threat-app-1"
#       image                = var.container_image
#       cpu                  = 256
#       memory               = 1024
#       memoryReservation    = 512
#       essential            = true


#       portMappings = [
#         {
#           name           = "container-port"
#           containerPort  = 3000
#           hostPort      = 3000
#           protocol      = "tcp"
#           appProtocol   = "http"
#         }
#       ]
#     }
#   ])

#   runtime_platform {
#     cpu_architecture        = "X86_64"
#     operating_system_family = "LINUX"
#   }
# }


# # ECS Service
# resource "aws_ecs_service" "this" {
#   name            = "threat-app-service"
#   cluster         = aws_ecs_cluster.threat_app_cluster.id
#   task_definition = aws_ecs_task_definition.this.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#    assign_public_ip = true
#     subnets         = var.subnet_ids
#     security_groups = [var.security_group_id]
#   }

#   load_balancer {
#     target_group_arn = var.target_group_arn
#     container_name   = "threat-app-1"
#     container_port   = 3000
#   }

#   deployment_controller {
#     type = "ECS"
#   }


# depends_on = [var.http_listener_arn, var.https_listener_arn]


# }



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

################################
# ECS Service
################################
resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
    assign_public_ip = var.assign_public_ip
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
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
