# Output the EC2 instance IP
output "instance_ip" {
  value = aws_instance.main.public_ip
}

# Output the ALB DNS name
output "alb_dns_name" {
  value = aws_alb.main.dns_name
}
