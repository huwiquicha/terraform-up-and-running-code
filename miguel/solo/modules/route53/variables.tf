variable "vpc_id" {
  description = "The VPC Id where the Route53 Hosted Zone will be used"
  type = string
  default = "vpc-0dc15ce6eda71bfcf"
}

variable "domain_name" {
  description = "The Domain Name"
  type = string
  default = "miguel-arroyo.com"
}