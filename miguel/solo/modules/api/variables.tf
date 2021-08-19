variable "aws_region" {
  default     = "us-east-2"
  description = "AWS Region to deploy example API Gateway REST API"
  type        = string
}

variable "rest_api_name" {
  default     = "miguel-api"
  description = "Name of the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}

variable "rest_api_stage" {
  default     = "miguel-example"
  description = "Path to create in the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}
