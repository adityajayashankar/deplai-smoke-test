# Define input variables
variable "aws_region" {
  type        = string
  default     = "us-west-2"
}

variable "aws_access_key" {
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  sensitive   = true
}
