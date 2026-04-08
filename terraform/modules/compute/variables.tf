variable "enabled" { type = bool }
variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "subnet_id" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "app_port" { type = number }
variable "bootstrap_index_html_base64" { type = string sensitive = true }
variable "instance_profile_name" { type = string }
variable "common_tags" { type = map(string) }
