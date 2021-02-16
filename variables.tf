######################################################
## Use TF Cloud variables or local terraform.tfvars
variable "aws_profile" { type = string }
# variable ""
variable "aws_region" { type = string }
variable "whoami" { type = string }
variable "db_read_capacity" { type = number }
variable "db_write_capacity" { type = number }
######################################################
## VPC Specific
variable "vpc_cidr" { type = string }
variable "nr_azs" { type = number }

variable "principl3_tld" { type = string }
variable "netnode_tld" { type = string }
variable "storage_tld" { type = string }