# ALB sg
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP/HTTPS from Internet"
  vpc_id      = module.frontend_vpc.vpc_id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound to frontend EC2"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# Frontend sg
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-ec2-sg"
  description = "Allow traffic from ALB and to backend"
  vpc_id      = module.frontend_vpc.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Outbound to backend Flask"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  tags = {
    Name = "frontend-ec2-sg"
  }
}


# Backend sg
resource "aws_security_group" "backend_sg" {
  name        = "backend-ec2-sg"
  description = "Allow traffic from frontend only"
  vpc_id      = module.backend_vpc.vpc_id

  ingress {
    description = "Flask from frontend VPC"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  egress {
    description = "Outbound to RDS"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.rds_sg.id]
  }

  tags = {
    Name = "backend-ec2-sg"
  }
}

# RDS sg
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from backend EC2 only"
  vpc_id      = module.backend_vpc.vpc_id

  ingress {
    description     = "MySQL from backend EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  egress {
    description     = "MySQL to backend EC2 only"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  tags = {
    Name = "rds-sg"
  }
}

