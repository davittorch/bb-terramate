output "aws_secrets_manager_arn" {
  value       = aws_secretsmanager_secret.rds_secret.arn
}
