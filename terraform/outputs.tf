# Output the EC2 instance ID
output "ec2_instance_id" {
  value = aws_instance.main.id
}

# Output the ALB DNS name
output "alb_dns_name" {
  value = aws_alb.main.dns_name
}
