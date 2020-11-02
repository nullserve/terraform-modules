variable "subdomain_prefix" {
  description = "The subdomain prefix name."
  type        = string
}

// TODO: Split this into a secondary module to allow cross-provider DNS?
variable "domain_zone_id" {
  description = "The root domain zone id."
  type        = string
}
