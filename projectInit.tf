provider "aws" {
  region = var.default_aws_region
  profile = var.aws_profile
}

module "iam_account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-account"

  account_alias = local.principl3_alias

  minimum_password_length = 37
  require_numbers         = false
}

resource "aws_dynamodb_table" "tfstate_table" {
  name = join("-",compact([ var.project_name,var.environment,var.whoami,"tfstate"])) 
  
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
    bucket = join("-",compact([ var.project_name,var.environment,var.whoami]))
 
    versioning {
      enabled = false
    }
 
    lifecycle {
      prevent_destroy = false
    }
}