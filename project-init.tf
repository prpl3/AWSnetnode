## TF Cloud variables ##############################
variable "default_aws_region" { type = string }   ##
variable "project_name" { type = string }        ##
variable "db_read_capacity" { type = number }     ##
variable "db_write_capacity" { type = number }    ##
####################################################

provider "aws" {
  region = var.default_aws_region
}

resource "random_pet" "table_name" {}

resource "aws_dynamodb_table" "tfc_example_table" {
  name = join("-",compact([ var.project_name,var.ENVIRONMENT,random_pet.table_name.id])) 
  
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

resource "aws_s3_bucket" "terraform_state_s3_bucket" {
    bucket = join("-",compact([ var.project_name,var.ENVIRONMENT,"state","files" ]))
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
}