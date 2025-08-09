# resource "aws_security_group" "this" {
#   vpc_id = var.vpc_id

#   name        = "${var.project_name}-sg"
#   description = "Security group for application"


#   ingress {
#     description = "http access"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = var.allowed_cidr_blocks


#   }

#   ingress {
#      description = "allow inbound traffic"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = var.allowed_cidr_blocks
#   }

#   ingress {
#     description = "allow container access"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = var.allowed_cidr_blocks
#   }

#   egress {
#     description = " outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.project_name}-sg"
#   }
# }


resource "aws_security_group" "this" {
  name        = "${var.project_name}-${var.environment}-ec2-sg"
  description = "Security group for application"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-ec2-sg"
  }
}
