module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name

  cidr = var.vpc_cidr
  azs             = data.aws_availability_zones.available.names
  public_subnets  = [cidrsubnet(var.vpc_cidr,8, 1 ),cidrsubnet(var.vpc_cidr,8, 2 ),cidrsubnet(var.vpc_cidr,8, 3 )]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = local.principl3_tag
    Deployed_by = local.deployed_by
    principl3_url = local.vpc_url
    storage_name = local.storage_name
    storage_url = local.storage_url
  }
}