variable "domain" {
  description = "The domain name to register."
  type        = string
}

variable "name" {
  default     = "NullServe Domain"
  description = "The application name to tag resources with."
  type        = string
}

variable "should_create" {
  default     = false
  description = "A switch to tell this module whether or not to create its resources."
  type        = bool
}

variable "stack_name" {
  default     = "NullServe Domain"
  description = "The stack name to tag resources with."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to add to the domain resource (if the provider supports tagging)."
  type        = map(string)
}

variable "ttl" {
  default     = 18600
  description = "Domain DNS TTL"
  type        = number
}
