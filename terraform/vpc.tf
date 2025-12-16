# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

module "frontend_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "frontend-vpc"
  cidr = "10.1.0.0/16"

  azs = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true //default the nat will be here: "10.1.101.0/24"(us-east-1a), so if us-east-1a will crash then the subntes from us-east-1b (10.1.102.0/24") will not have internet connection => fix 2 nat for each public subnet
  enable_vpn_gateway = false

  tags = {
    Environment = "dev"
    VPC         = "frontend"
  }
}

module "backend_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "backend-vpc"
  cidr = "10.2.0.0/16"

  azs = ["us-east-1a", "us-east-1b"]

  private_subnets = ["10.2.1.0/24", "10.2.2.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Environment = "dev"
    VPC         = "backend"
  }
}

resource "aws_vpc_peering_connection" "frontend_backend" {
  vpc_id      = module.frontend_vpc.vpc_id
  peer_vpc_id = module.backend_vpc.vpc_id
  auto_accept = true

  tags = {
    Name = "frontend-backend-peering"
  }
}

# Notes:
# module.backend_vpc.private_route_table_ids[0] -> route only for "10.2.1.0/24" subnet.
# module.backend_vpc.private_route_table_ids[1] -> route only for "10.2.2.0/24" subnet.
# if  want to use for both subnets i can do like this:
#   for_each = toset(module.backend_vpc.private_route_table_ids)
#   route_table_id            = each.value

resource "aws_route" "backend_to_frontend" {
  route_table_id             = module.backend_vpc.private_route_table_ids[0]  # -> route only for "10.2.1.0/24" subnet (backend), so the subnet of the rds ("10.2.2.0/24") will not have direct connection with frontend (security)
  destination_cidr_block     = "10.1.0.0/16"
  vpc_peering_connection_id  = aws_vpc_peering_connection.frontend_backend.id
}
