## TF Cloud variables ##############################
variable "default_aws_region" { type = string }   ##
variable "db_table_name" { type = string }        ##
variable "db_read_capacity" { type = number }     ##
variable "db_write_capacity" { type = number }    ##
####################################################


provider "aws" {
  region = var.default_aws_region
}

resource "random_pet" "table_name" {}

resource "aws_dynamodb_table" "tfc_example_table" {
  name = "${var.db_table_name}-${random_pet.table_name.id}"

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
