variable "backend" {
  default     = "aws"
  description = "The cloud provider to use as a backend for the resources."
  type        = string

  validation {
    condition     = contains(["aws"], var.backend)
    error_message = "The backend must be a supported backend. Must be one of: [aws]."
  }
}

variable "nullserve_domain" {
  description = "The domain name used by the nullserve management application."
  type        = string
}