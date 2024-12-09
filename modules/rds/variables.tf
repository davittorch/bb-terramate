variable "instance_class" {
  description = "The instance type of the RDS instance"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
}

variable "max_allocated_storage" {
  description = "The maximum allocated storage in gigabytes (enables autoscaling)"
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
}

variable "username" {
  description = "Username for the database administrator"
}

variable "password" {
  description = "Password for the database administrator"
}

variable "port" {
  description = "The port on which the DB accepts connections"
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
}

variable "database_subnet_group" {
  description = "Database subnet group"
}

variable "vpc_security_group_ids" {
  description = "Vpc security group id"
}