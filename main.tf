provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}
resource "aws_dynamodb_table" "tfstate_table" {
  name = join("-",compact([local.vpc_name,"tfstate"])) 
  
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
    bucket = local.storage_name
 
    versioning {
      enabled = false
    }
 
    lifecycle {
      prevent_destroy = false
    }
}