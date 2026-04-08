# Create a new VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Create a new subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

# Create a new security group
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a new EC2 instance
resource "aws_instance" "main" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id = aws_subnet.main.id
}

# Create a new ALB
resource "aws_alb" "main" {
  name            = "deplai-smoke-test-alb"
  subnets         = [aws_subnet.main.id]
  security_groups = [aws_security_group.main.id]
}

# Create a new ALB target group
resource "aws_alb_target_group" "main" {
  name     = "deplai-smoke-test-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Create a new ALB listener
resource "aws_alb_listener" "main" {
  load_balancer_arn = aws_alb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main.arn
    type             = "forward"
  }
}
