module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.principl3_tag
  cidr = var.vpc_cidr
  # count = var.nr_azs
  azs             = data.aws_availability_zones.available.names
  # public_subnets  = [cidrsubnet(var.vpc_cidr,8,count.index + 1 )] # ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  # private_subnets = [cidrsubnet(var.vpc_cidr,8,count.index + 101 )] # ["172.16.101.0/24", "172.16.102.0/24", "172.16.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = local.principl3_tag
    Deployed_by = local.deployed_by
  }
}