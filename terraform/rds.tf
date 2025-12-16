resource "random_password" "mysql_pass" {
  length  = 24
  special = false
}

resource "aws_db_subnet_group" "backend_db_subnet_group" {
  name = "backend-db-subnet-group"

  subnet_ids = module.backend_vpc.private_subnets // "10.2.1.0/24", "10.2.2.0/24"
  tags = {
    Name = "backend-db-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier = "backend-mysql"
  allocated_storage    = 10
  db_name              = "appdb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t4g.micro"
  username             = "rds_username"
  password = random_password.mysql_pass.result
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.backend_db_subnet_group.name

}

resource "aws_secretsmanager_secret" "mysql_secret" {
  name = "backend-mysql-secret"
  recovery_window_in_days = 30

  lifecycle {
    prevent_destroy = true
  }
  
}

resource "aws_secretsmanager_secret_version" "mysql_secret_version" {
  secret_id = aws_secretsmanager_secret.mysql_secret.id

  secret_string = jsonencode({
    username = "rds_username"
    password = random_password.mysql_pass.result
    host     = aws_db_instance.mysql.address
    port     = 3306
    dbname   = "appdb"
  })
}


