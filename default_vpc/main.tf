module "aws_default_vpc" {
  source        = "./aws"
  should_create = var.backend == "aws"
}
