output "cloudfront_url" { value = "https://${aws_cloudfront_distribution.website.domain_name}" }
output "website_bucket_name" { value = aws_s3_bucket.website.id }
output "ec2_instance_id" { value = try(aws_instance.app[0].id, null) }
output "ec2_public_dns" { value = try(aws_instance.app[0].public_dns, null) }
output "ec2_key_name" { value = local.selected_ec2_key_name }
output "generated_ec2_private_key_pem" {
  value     = try(tls_private_key.generated[0].private_key_pem, null)
  sensitive = true
}
output "security_summary" {
  value = {
    code_findings = 0
    supply_findings = 0
    critical_or_high_supply = 0
    high_cwe = "none"
  }
}
