variable "backend" {
  default     = "aws"
  description = "The cloud provider to use as a backend for the resources."
  type        = string

  validation {
    condition     = contains(["aws"], var.backend)
    error_message = "The backend must be a supported backend. Must be one of: [aws]."
  }
}

variable "domain" {
  description = "The domain name to use for applications."
  type        = string
}
