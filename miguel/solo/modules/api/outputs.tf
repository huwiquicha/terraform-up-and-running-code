#
# Outputs
#

output "curl_stage_invoke_url" {
  description = "API Gateway Stage Invoke URL"
  value       = "curl ${aws_api_gateway_stage.example.invoke_url}/${var.rest_api_stage}"
}
