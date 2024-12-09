variable "secret_name" {
  type        = string
  description = "The name of the AWS Secrets Manager secret."
}

variable "secret_description" {
  type        = string
  description = "A description of the AWS Secrets Manager secret."
}

variable "recovery_window_in_days" {
  type        = number
  description = "The number of days that AWS Secrets Manager waits before permanently deleting the secret."
}

variable "prevent_destroy" {
  type        = bool
  description = "Whether to prevent the Terraform resource from being destroyed. Useful for sensitive data."
  default = false
}

variable "rds_endpoint" {
  type        = string
  description = "The endpoint of the RDS instance, used for constructing the secret."
}

variable "rds_master_user" {
  type        = string
  description = "The username for the RDS master user, stored in the secret."
}

variable "rds_password" {
  type        = string
  description = "The password for the RDS master user, stored in the secret."
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "The name of the database, stored in the secret."
}
