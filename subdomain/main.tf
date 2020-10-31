module "aws_subdomain" {
  domain        = var.domain
  source        = "./aws"
  should_create = var.backend == "aws"
}