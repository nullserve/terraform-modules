variable "name" {
  default     = "NullServe Default Access Logs"
  description = "The application name to tag resources with."
  type        = string
}

variable "should_create" {
  default     = false
  description = "A switch to tell this module whether or not to create its resources."
  type        = bool
}

variable "stack_name" {
  default     = "NullServe Default Access Logs"
  description = "The stack name to tag resources with."
  type        = string
}
