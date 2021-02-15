## TF Cloud variables ##############################
variable "aws_profile" { type = string }
variable "default_aws_region" { type = string }
variable "whoami" { type = string } 
variable "environment" { type = string } 
variable "project_name" { type = string }
variable "db_read_capacity" { type = number }
variable "db_write_capacity" { type = number }
####################################################

provider "aws" {
  region = var.default_aws_region
  profile = var.aws_profile
}

resource "aws_dynamodb_table" "tfstate_table" {
  name = join("-",compact([ var.project_name,var.environment,var.whoami])) 
  
  read_capacity  = var.db_read_capacity
  write_capacity = var.db_write_capacity
  hash_key       = "UUID"
  range_key      = "UserName"

  attribute {
    name = "UUID"
    type = "S"
  }

  attribute {
    name = "UserName"
    type = "S"
  }
}

resource "aws_s3_bucket" "tfstate_s3" {
    bucket = join("-",compact([ var.project_name,var.environment,var.whoami,"s3"]))
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
}

# terraform {
#   backend "s3" {
#     bucket = "netnode-terraform-state-file-storage"
#     profile = var.aws_profile
#     key    = "netnode/space/infrastucture"
#     region = "eu-central-1"
#     dynamodb_table = "netnode-terraform-state-locking"
#     encrypt = true # Optional, S3 Bucket Server Side Encryption
#   }
# }