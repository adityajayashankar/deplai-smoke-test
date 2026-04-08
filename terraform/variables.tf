# Define input variables
variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region to deploy to"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type to use for EC2 instance"
}
