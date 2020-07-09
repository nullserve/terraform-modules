output "domain_name_servers" {
  value = map(
    "aws", module.aws_domain.domain_name_servers
  )[var.backend]
}
