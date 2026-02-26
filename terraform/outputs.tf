output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

# output "bastion_public_ip" {
#   value = aws_instance.bastion.public_ip
# }

output "cognito_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.client.id
}