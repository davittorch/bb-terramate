resource "aws_secretsmanager_secret" "rds_secret" {
  name        = var.secret_name
  description = var.secret_description
  recovery_window_in_days = var.recovery_window_in_days

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    host     = split(":", var.rds_endpoint)[0]
    username = var.rds_master_user
    password = var.rds_password
    dbname   = var.db_name
  })
}
