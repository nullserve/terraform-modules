module "aws_domain" {
  domain        = var.domain
  source        = "./aws"
  should_create = var.backend == "aws"
}
