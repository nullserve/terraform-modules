variable "domain" {
  description = "The domain name to register."
  type        = string
}

variable "should_create" {
  default     = false
  description = "A switch to tell this module whether or not to create its resources."
  type        = bool
}
