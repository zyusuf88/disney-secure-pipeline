terraform {
  required_version = ">= 1.11.2, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


data "aws_acm_certificate" "existing" {
  domain   = "${var.record_name}.${var.domain_name}"
  statuses = ["ISSUED"]

}
