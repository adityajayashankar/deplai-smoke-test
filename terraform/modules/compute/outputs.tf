output "ec2_instance_id" { value = try(aws_instance.app[0].id, null) }
output "ec2_instance_arn" { value = try(aws_instance.app[0].arn, null) }
output "ec2_instance_state" { value = try(aws_instance.app[0].instance_state, null) }
output "ec2_instance_type" { value = try(aws_instance.app[0].instance_type, null) }
output "ec2_public_ip" { value = try(aws_instance.app[0].public_ip, null) }
output "ec2_private_ip" { value = try(aws_instance.app[0].private_ip, null) }
output "ec2_public_dns" { value = try(aws_instance.app[0].public_dns, null) }
output "ec2_private_dns" { value = try(aws_instance.app[0].private_dns, null) }
output "ec2_subnet_id" { value = try(aws_instance.app[0].subnet_id, null) }
output "ec2_key_name" { value = try(aws_key_pair.generated[0].key_name, null) }
output "generated_ec2_private_key_pem" { value = try(tls_private_key.generated[0].private_key_pem, null) sensitive = true }
