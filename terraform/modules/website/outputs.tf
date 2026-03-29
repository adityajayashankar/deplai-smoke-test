output "website_bucket" {
  value = aws_s3_bucket.website.bucket
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.cdn.domain_name}"
}
