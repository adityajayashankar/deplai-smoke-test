output "rds_endpoint" { value = try(aws_db_instance.postgres[0].address, null) }
output "redis_endpoint" { value = null }
