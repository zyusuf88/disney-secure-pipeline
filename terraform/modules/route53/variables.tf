
variable "record_name" {
  description = "The subdomain or record name (e.g., tm)"
  type = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type = string
}

# variable "alb_zone_id" {
#   type = string
# }

# variable "certificate_arn" {
#   type = string
# }

variable "domain_name" {
  description = "Domain name for the app"
  type        = string
}

variable "type" {
  description = "DNS record type for the Route 53 record "
  type        = string
}

variable "ttl" {
  description = "Time-to-live (TTL) for the DNS record "
  type        = number

}
