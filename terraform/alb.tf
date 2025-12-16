# ALB -> create public ALB
resource "aws_lb" "frontend_alb" {
  name               = "frontend-alb"
  load_balancer_type = "application"
  internal           = false # -> public alb

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = module.frontend_vpc.public_subnets

  tags = {
    Name = "frontend-alb"
  }
}


# Target Group -> alb sends the traffic
resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = module.frontend_vpc.vpc_id

  health_check {
    path                = "/"
  }

  tags = {
    Name = "frontend-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}
