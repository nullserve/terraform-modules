// TODO: Split this into a secondary module to allow cross-provider DNS?
variable "domain_zone_id" {
  description = "The root domain zone id."
  type        = string
}

variable "name" {
  default     = "NullServe Subdomain"
  description = "The application name to tag resources with."
  type        = string
}

variable "should_create" {
  default     = false
  description = "A switch to tell this module whether or not to create its resources."
  type        = bool
}

variable "stack_name" {
  default     = "NullServe Subdomain"
  description = "The stack name to tag resources with."
  type        = string
}

variable "subdomain_prefix" {
  description = "The subdomain prefix domain name."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to add to the domain resource (if the provider supports tagging)."
  type        = map(string)
}
