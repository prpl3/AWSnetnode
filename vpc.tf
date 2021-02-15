data "aws_availability_zones" "available" {}

#   data "aws_security_group" "default" {
#   name   = "default"
#   vpc_id = module.vpc.vpc_id
# }

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = join("-",compact([ var.project_name,var.environment,var.whoami]))
  cidr = "10.0.0.0/16"

  azs             = ["${var.default_aws_region}a", "${var.default_aws_region}b", "${var.default_aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}