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


data "aws_acm_certificate" "existing" {
  domain   = "${var.record_name}.${var.domain_name}"
  statuses = ["ISSUED"]

}
