terraform {
  required_version = ">= 1.0"
}

provider "aws" {
  region = local.region
}

locals {
  region = "us-east-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Name = "Subnet for ALB"
  }

  tags = {
    Owner       = "miguel.c"
    Environment = "dev"
  }

  vpc_tags = {
    Name = var.vpc_name
  }
}

