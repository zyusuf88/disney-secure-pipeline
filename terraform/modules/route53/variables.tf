
variable "record_name" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "alb_zone_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

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
