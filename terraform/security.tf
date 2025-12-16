# ALB sg
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  description = "Allow HTTP/HTTPS from Internet"
  vpc_id = module.frontend_vpc.vpc_id
}

resource "aws_security_group_rule" "http_from_public" {
  security_group_id        = aws_security_group.alb_sg.id

  description              = "HTTP from public"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_from_public" {
  security_group_id        = aws_security_group.alb_sg.id

  description              = "HTTPS from public"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_to_frontend" {
  security_group_id        = aws_security_group.alb_sg.id
  
  description              = "Outbound to everywhere"
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
}


# Frontend sg
resource "aws_security_group" "frontend_sg" {
  name   = "frontend-sg"
  description = "Allow traffic from ALB and to backend"
  vpc_id = module.frontend_vpc.vpc_id
}

resource "aws_security_group_rule" "frontend_from_alb" {
  security_group_id        = aws_security_group.frontend_sg.id

  description              = "HTTP from ALB"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "frontend_to_backend" {
  security_group_id        = aws_security_group.frontend_sg.id
  
  description              = "Outbound to backend Flask"
  type                     = "egress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend_sg.id
}


# Backend sg
resource "aws_security_group" "backend_sg" {
  name   = "backend-sg"
  description = "Allow traffic from frontend only"
  vpc_id = module.backend_vpc.vpc_id
}

resource "aws_security_group_rule" "backend_from_frontend" {
  security_group_id        = aws_security_group.backend_sg.id

  description              = "Flask from frontend VPC"
  type                     = "ingress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.frontend_sg.id
}

resource "aws_security_group_rule" "backend_to_rds" {
  security_group_id        = aws_security_group.backend_sg.id
  
  description              = "Outbound to RDS"
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds_sg.id
}

# RDS sg
resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  description = "Allow MySQL from backend EC2 only"
  vpc_id = module.backend_vpc.vpc_id
}

resource "aws_security_group_rule" "rds_from_backend" {
  security_group_id        = aws_security_group.rds_sg.id

  description              = "MySQL from backend EC2"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend_sg.id
}

# resource "aws_security_group_rule" "rds_to_backend" {
#   security_group_id        = aws_security_group.rds_sg.id
  
#   description              = "RDS back to backend"
#   type                     = "egress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.backend_sg.id
# }

