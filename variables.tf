variable domain_name {
  type        = string
  description = "Domain name for website"
}

variable profile {
  type        = string
  default     = "default"
  description = "AWS profile name"
}

variable region {
  type        = string
  description = "AWS region"
}
