output "cloudfront_url" {
  value = null
}

output "cloudfront_domain_name" {
  value = null
}

output "website_bucket_name" {
  value = null
}

output "alb_dns_name" {
  value = null
}

output "rds_endpoint" {
  value = module.data.rds_endpoint
}

output "redis_endpoint" {
  value = module.data.redis_endpoint
}

output "ec2_instance_id" {
  value = module.compute.ec2_instance_id
}

output "ec2_instance_arn" {
  value = module.compute.ec2_instance_arn
}

output "ec2_instance_state" {
  value = module.compute.ec2_instance_state
}

output "ec2_instance_type" {
  value = module.compute.ec2_instance_type
}

output "ec2_public_ip" {
  value = module.compute.ec2_public_ip
}

output "ec2_private_ip" {
  value = module.compute.ec2_private_ip
}

output "ec2_public_dns" {
  value = module.compute.ec2_public_dns
}

output "ec2_private_dns" {
  value = module.compute.ec2_private_dns
}

output "ec2_vpc_id" {
  value = module.networking.vpc_id
}

output "ec2_subnet_id" {
  value = module.compute.ec2_subnet_id
}

output "ec2_key_name" {
  value = module.compute.ec2_key_name
}

output "generated_ec2_private_key_pem" {
  value     = module.compute.generated_ec2_private_key_pem
  sensitive = true
}
