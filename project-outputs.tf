output "tfstate_table" {
  value = aws_dynamodb_table.tfstate_table.arn
}
output "tfstate_s3" {
  value = aws_dynamodb_table.tfstate_s3.arn
}

