data "aws_availability_zones" "available" { state = "available" }

data "aws_vpc" "default" { count = var.use_existing_vpc ? 1 : 0 default = true }

data "aws_subnets" "default" {
  count = var.use_existing_vpc ? 1 : 0
  filter { name = "vpc-id" values = [data.aws_vpc.default[0].id] }
}

resource "aws_vpc" "main" {
  count                = var.use_existing_vpc ? 0 : 1
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(var.common_tags, { Name = "${var.project_name}-${var.environment}-vpc" })
}

resource "aws_internet_gateway" "main" {
  count  = var.use_existing_vpc ? 0 : 1
  vpc_id = aws_vpc.main[0].id
  tags   = merge(var.common_tags, { Name = "${var.project_name}-${var.environment}-igw" })
}

resource "aws_subnet" "public" {
  count                   = var.use_existing_vpc ? 0 : 2
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.common_tags, { Name = "${var.project_name}-${var.environment}-public-${count.index + 1}" })
}

resource "aws_subnet" "private" {
  count             = var.use_existing_vpc ? 0 : 2
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.common_tags, { Name = "${var.project_name}-${var.environment}-private-${count.index + 1}" })
}

resource "aws_route_table" "public" {
  count  = var.use_existing_vpc ? 0 : 1
  vpc_id = aws_vpc.main[0].id
  tags   = merge(var.common_tags, { Name = "${var.project_name}-${var.environment}-public-rt" })
}

resource "aws_route" "public_internet" {
  count                  = var.use_existing_vpc ? 0 : 1
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[0].id
}

resource "aws_route_table_association" "public" {
  count          = var.use_existing_vpc ? 0 : length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

locals {
  vpc_id            = var.use_existing_vpc ? data.aws_vpc.default[0].id : aws_vpc.main[0].id
  public_subnet_ids = var.use_existing_vpc ? slice(data.aws_subnets.default[0].ids, 0, min(length(data.aws_subnets.default[0].ids), 2)) : [for subnet in aws_subnet.public : subnet.id]
  private_subnet_ids = var.use_existing_vpc ? local.public_subnet_ids : [for subnet in aws_subnet.private : subnet.id]
}
