# Define output values
output "alb_dns_name" {
  value = aws_alb.main.dns_name
}

output "ec2_instance_id" {
  value = aws_instance.main.id
}
