# 1. Security Group for the Application Load Balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow inbound HTTP traffic to ALB"
  vpc_id      = aws_vpc.vpc_1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-Security-Group"
  }
}

# 2. Application Load Balancer (Internet-facing)
resource "aws_lb" "main_alb" {
  name               = "main-application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  
  # Attach to Public Subnets in both AZs for High Availability
  subnets = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id
  ]

  tags = {
    Name = "Main-ALB"
  }
}

# 3. Target Group (Destination for the traffic)
resource "aws_lb_target_group" "main_tg" {
  name     = "main-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_1.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "Main-Target-Group"
  }
}