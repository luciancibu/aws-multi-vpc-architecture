resource "aws_instance" "frontend_ec2" {
  ami           = data.aws_ami.amazon_linux_2.id # Amazon Linux 2 (us-east-1)
  instance_type = "t3.micro"

  subnet_id = module.frontend_vpc.private_subnets[0]

  vpc_security_group_ids = [
    aws_security_group.frontend_sg.id
  ]

  associate_public_ip_address = false

user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y nginx
systemctl restart nginx
systemctl enable nginx
EOF

  tags = {
    Name = "frontend-nginx"
  }
}

