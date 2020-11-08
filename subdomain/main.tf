module "aws_subdomain" {
  root_domain      = var.root_domain
  source           = "./aws"
  should_create    = var.backend == "aws"
  subdomain_prefix = var.subdomain_prefix
}
