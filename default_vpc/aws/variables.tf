variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "The CIDR block to use for the VPC. IPv4; max /16"
  type        = string
}

variable "name" {
  default     = "unnamed"
  description = "The name of this VPC"
  type        = string
}

variable "stack_name" {
  default     = "NullServe Default VPC"
  description = "The name of the stack"
  type        = string
}

variable "should_create" {
  default     = false
  description = "A switch to tell this module whether or not to create its resources."
  type        = bool
}

variable "tags" {
  default     = {}
  description = "Tags applied to the VPC resources"
  type        = map
}
