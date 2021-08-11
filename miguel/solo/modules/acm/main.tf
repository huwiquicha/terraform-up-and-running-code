terraform {
  required_version = ">= 1.0"
}

provider "aws" {
  region = local.region
}

locals {
  region = "us-east-2"
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"

  domain_name = var.domain_name
  zone_id     = var.zone_id

  wait_for_validation = true

  tags = {
    Name = var.domain_name
    Env = "dev"
  }
}