output "tfstate_table" {
  value = aws_dynamodb_table.tfstate_table.arn
}
output "tfstate_s3" {
  value = aws_s3_bucket.tfstate_s3.arn
}

output "message" { value = "Base infrastructure exists, continue deploying new components from seperate repositories"}