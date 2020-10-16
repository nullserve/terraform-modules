module "default_vpc" {
  backend = "aws"
  source  = "../../default_vpc"
}

module "default_log" {
  backend = "aws"
  source  = "../..default_log"
}

module "domain" {
  backend = "aws"
  source  = "../../domain"
}

module "origin_service" {
  backend = "aws"
  source  = "../..origin_service"
}
