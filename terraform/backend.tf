# Configure the Terraform backend
terraform {
  backend "s3" {
    bucket = "deplai-smoke-test-terraform-state"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
