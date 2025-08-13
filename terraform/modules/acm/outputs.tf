output "certificate_arn" {
  value = data.aws_acm_certificate.existing.arn
  description = "The ARN of the ACM certificate used for the application"
}
