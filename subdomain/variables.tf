variable "backend" {
  default     = "aws"
  description = "The cloud provider to use as a backend for the resources."
  type        = string

  validation {
    condition     = contains(["aws"], var.backend)
    error_message = "The backend must be a supported backend. Must be one of: [aws]."
  }
}

variable "root_domain" {
  description = "The root domain that contains the subdomain to be created."
  type        = string
}

variable "subdomain_prefix" {
  description = "The subdomain with which the root domain will be prefixed."
  type        = string
}
