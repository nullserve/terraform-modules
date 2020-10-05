module "aws_origin_service" {
  source        = "./aws"
  should_create = var.backend == "aws"
}
