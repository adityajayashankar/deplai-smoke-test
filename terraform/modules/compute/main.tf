locals {
  use_existing_key = trimspace(var.existing_ec2_key_pair_name) != ""
  ec2_key_name     = local.use_existing_key ? trimspace(var.existing_ec2_key_pair_name) : aws_key_pair.generated[0].key_name
}

resource "aws_security_group" "app" {
  count       = var.enabled ? 1 : 0
  name_prefix = "${var.project_name}-${var.environment}-app-"
  description = "Application traffic"
  vpc_id      = var.vpc_id
  tags        = var.common_tags

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "generated" {
  count     = var.enabled && !local.use_existing_key ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  count      = var.enabled && !local.use_existing_key ? 1 : 0
  key_name   = "${var.project_name}-${var.environment}-key"
  public_key = tls_private_key.generated[0].public_key_openssh
}

resource "aws_instance" "app" {
  count                       = var.enabled ? 1 : 0
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.app[0].id]
  iam_instance_profile        = var.instance_profile_name
  key_name                    = local.ec2_key_name
  associate_public_ip_address = true
  tags                        = merge(var.common_tags, { Name = "${var.project_name}-${var.environment}-app" })

  metadata_options { http_tokens = "required" }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 8
  }

  user_data = join("\n", [
    "#!/bin/bash",
    "set -euxo pipefail",
    "dnf install -y nginx",
    "mkdir -p /usr/share/nginx/html",
    "cat <<'HTML' > /usr/share/nginx/html/index.html",
    "${base64decode(var.bootstrap_index_html_base64)}",
    "HTML",
    "systemctl enable nginx",
    "systemctl restart nginx"
  ])
}
