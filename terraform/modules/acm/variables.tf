variable "domain_name" {
  description = "Domain name for the application"
  type = string
}

variable "record_name" {
  type = string
  description = "The subdomain or record name (e.g., tm)"
}
