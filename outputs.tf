output "Principl3_tag" { value = local.principl3_tags }

output "tfstate_table" {
  value = aws_dynamodb_table.tfstate_table.arn
}
output "tfstate_s3" {
  value = aws_s3_bucket.tfstate_s3.arn
}

output "message" { value = ["${local.principl3_tag} principl3_link : ${local.deployed_by}"]}
