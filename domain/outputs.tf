output "domain_name_servers" {
  value = map(
    "aws", module.domain_name_servers
  )[var.backend]
}
