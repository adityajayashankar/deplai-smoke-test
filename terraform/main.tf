module "networking" {
  source               = "./modules/networking"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  use_existing_vpc     = var.use_existing_vpc || var.use_default_vpc
  common_tags          = local.common_tags
}

module "iam" {
  source        = "./modules/iam"
  project_name  = var.project_name
  environment   = var.environment
  region        = var.region
  secret_prefix = var.secrets_manager_prefix
  common_tags   = local.common_tags
}

module "data" {
  source          = "./modules/data"
  enable_postgres = local.enable_postgres
  enable_redis    = local.enable_redis
  vpc_id          = module.networking.vpc_id
  subnet_ids      = module.networking.private_subnet_ids
  allowed_cidrs   = [var.vpc_cidr]
  common_tags     = local.common_tags
}

module "compute" {
  source                      = "./modules/compute"
  enabled                     = local.enable_compute
  project_name                = var.project_name
  environment                 = var.environment
  vpc_id                      = module.networking.vpc_id
  subnet_id                   = module.networking.public_subnet_ids[0]
  ami_id                      = data.aws_ami.al2023.id
  instance_type               = var.instance_type
  app_port                    = var.app_port
  bootstrap_index_html_base64 = var.bootstrap_index_html_base64
  instance_profile_name       = module.iam.instance_profile_name
  existing_ec2_key_pair_name  = var.existing_ec2_key_pair_name
  common_tags                 = local.common_tags
}
