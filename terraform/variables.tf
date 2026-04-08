# Define variables
variable "aws_region" {
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  type        = string
  default     = "ami-0c94855ba95c71c99"
}
