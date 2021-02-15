######################################################
## Use TF Cloud variables or local terraform.tfvars
variable "aws_profile" { type = string }
variable "default_aws_region" { type = string }
variable "whoami" { type = string } 
variable "environment" { type = string } 
variable "project_name" { type = string }
variable "db_read_capacity" { type = number }
variable "db_write_capacity" { type = number }
######################################################
## VPC Specific
variable "vpc_cidr" { type = string }
variable "nr_azs" { type = number }

variable "public_subnets" { }
variable "private_subnets" { }