variable "enable_postgres" { type = bool }
variable "enable_redis" { type = bool }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "allowed_cidrs" { type = list(string) }
variable "common_tags" { type = map(string) }
