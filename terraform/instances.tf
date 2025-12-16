resource "aws_instance" "frontend_ec2" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  subnet_id = module.frontend_vpc.private_subnets[0]

  user_data = templatefile("${path.module}/user_data/frontend_nginx.sh", {
    backend_ip = aws_instance.backend.private_ip
  })

  depends_on = [aws_instance.backend]
  tags = {
    Name = "frontend-nginx"
  }
}

resource "aws_instance" "backend" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  subnet_id              = module.backend_vpc.private_subnets[0]

  tags = {
    Name = "backend-ec2"
  }
}
