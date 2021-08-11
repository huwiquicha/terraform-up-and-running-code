terraform {
  required_version = ">= 1.0"
}

provider "aws" {
  region = local.region
}

locals {
  region = "us-east-2"
}

resource "aws_route53_zone" "private" {
  name = var.domain_name

  vpc {
    vpc_id = var.vpc_id
  }
}