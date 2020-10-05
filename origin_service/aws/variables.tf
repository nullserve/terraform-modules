variable "access_log_bucket" {
  description = "The bucket where access logs will be delivered"
  type        = string
}

variable "app_subdomain_prefix" {
  default     = "app"
  description = "The subdomain to use for app aliases"
  type        = string
}

variable "domain" {
  description = "The domain which you will host NullServe"
  type        = string
}

variable "elb_origin_service_access_logging_prefix" {
  default     = "origin_service"
  description = "The prefix string to use for the access logging bucket logs"
  type        = string
}

variable "external_subnet_ids" {
  description = "External subnets to use for the origin service load balancer"
  type        = list(string)
}

variable "name" {
  default     = "NullServe Origin Service"
  description = "The application name to tag resources with."
  type        = string
}

variable "should_create" {
  default     = false
  description = "A switch to tell this module whether or not to create its resources."
  type        = bool
}

variable "stack_name" {
  default     = "NullServe Origin Service"
  description = "The stack name to tag resources with."
  type        = string
}

variable "ref_subdomain_prefix" {
  default     = "ref"
  description = "The subdomain to use for app id references"
  type        = string
}

variable "vpc_id" {
  description = "The vpc from which origin service will be run"
  type        = string
}

variable "stack_name" {
  default     = "NullServe Origin Service"
  description = "The stack name to tag resources with."
  type        = string
}
