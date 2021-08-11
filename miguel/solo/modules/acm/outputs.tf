output "acm_certificate_arn" {
    value = module.acm.acm_certificate_arn
}

output "validation_route53_record_fqdns" {
    value = module.acm.validation_route53_record_fqdns
}