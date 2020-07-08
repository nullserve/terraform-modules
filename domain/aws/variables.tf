variable "app_prefix" {
  default     = "app"
  description = "The prefix for named app aliases; used with domain."
  type        = string
}

variable "domain" {
  description = "The domain name to register."
  type        = string
}

variable "name" {
  default     = "NullServe Domain"
  description = "The application name to tag resources with."
  type        = string
}

variable "ref_prefix" {
  default     = "ref"
  description = "The prefix for app by reference id; used with domain."
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

variable "subdomain_ttl" {
  default     = 86400
  description = "The TTL for subdomain NS records. Affects DNS caching."
  type        = number
}

variable "tags" {
  default     = {}
  description = "Tags to add to the domain resource (if the provider supports tagging)."
  type        = map(string)
}
