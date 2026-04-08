resource "aws_security_group" "database" {
  count       = var.enable_postgres || var.enable_redis ? 1 : 0
  name_prefix = "database-"
  description = "Database access"
  vpc_id      = var.vpc_id
  tags        = var.common_tags

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "postgres" {
  count      = var.enable_postgres ? 1 : 0
  name       = "postgres-${substr(md5(join(",", var.subnet_ids)), 0, 8)}"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "postgres" {
  count                       = var.enable_postgres ? 1 : 0
  identifier                  = "postgres-${substr(md5(join(",", var.subnet_ids)), 0, 8)}"
  engine                      = "postgres"
  engine_version              = "15.5"
  instance_class              = "db.t4g.micro"
  allocated_storage           = 20
  db_subnet_group_name        = aws_db_subnet_group.postgres[0].name
  vpc_security_group_ids      = [aws_security_group.database[0].id]
  publicly_accessible         = false
  skip_final_snapshot         = true
  manage_master_user_password = true
  storage_encrypted           = true
  username                    = "appadmin"
  db_name                     = "appdb"
  tags                        = var.common_tags
}
