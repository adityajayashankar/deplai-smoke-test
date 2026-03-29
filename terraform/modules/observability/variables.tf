variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "enable_cloudwatch" {
  type = bool
}

variable "log_retention_days" {
  type = number
}

variable "enable_ec2" {
  type = bool
}

variable "instance_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
