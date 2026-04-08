locals {
  common_tags = {
    environment = var.environment
    team        = var.team
    cost_center = var.cost_center
    managed_by  = "terraform"
  }

  enable_compute     = var.compute_strategy == "ec2"
  enable_static_site = var.compute_strategy == "s3_cloudfront"
  enable_postgres    = var.enable_postgres
  enable_redis       = var.enable_redis
}
