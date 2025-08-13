terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  required_version = ">= 1.6, < 2.0"
}



data "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.this.id
  name    = "${var.record_name}.${var.domain_name}"
  type    = var.type
  ttl     = var.ttl
  records = [var.alb_dns_name]
}
