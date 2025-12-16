# https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest

module "ec2_ssm_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"

  name = "ec2-ssm-role"

  trust_policy_permissions = {
    EC2Trust = {
      actions = ["sts:AssumeRole"]
      principals = [{
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }]
    }
  }

  policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "ec2-ssm-profile"
  role = module.ec2_ssm_role.name
}
