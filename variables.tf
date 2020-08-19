variable domain_name {
  type        = string
  description = "Domain name for website"
}

variable error_file {
  type        = string
  default     = "error.html"
  description = "Reference the error html."
}

variable index_file {
  type        = string
  default     = "index.html"
  description = "Reference the index html."
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
