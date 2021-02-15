## TF Cloud variables ##############################
variable "default_aws_region" { type = string }
variable "environment" { type = string } 
variable "project_name" { type = string }
variable "db_read_capacity" { type = number }
variable "db_write_capacity" { type = number }
####################################################

provider "aws" {
  region = var.default_aws_region
}

resource "random_pet" "table_name" {}

resource "aws_dynamodb_table" "tfstate_table" {
  name = join("-",compact([ var.project_name,var.environment,random_pet.table_name.id])) 
  
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
    bucket = join("-",compact([ var.project_name,var.environment,"state","files" ]))
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
}