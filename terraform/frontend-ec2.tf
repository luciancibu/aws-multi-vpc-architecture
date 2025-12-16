resource "aws_instance" "frontend_ec2" {
  ami           = data.aws_ami.amazon_linux_2.id # Amazon Linux 2 (us-east-1)
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name
  instance_type = "t3.micro"

  subnet_id = module.frontend_vpc.private_subnets[0]

  vpc_security_group_ids = [
    aws_security_group.frontend_sg.id
  ]

  associate_public_ip_address = false

user_data = <<-EOF
#!/bin/bash
yum update -y
amazon-linux-extras install -y nginx1
systemctl restart nginx
systemctl enable nginx
EOF

  tags = {
    Name = "frontend-nginx"
  }
}

