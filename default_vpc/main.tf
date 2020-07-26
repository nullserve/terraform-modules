module "aws_vpc" {
  source        = "./aws"
  should_create = var.backend == "aws"
}
