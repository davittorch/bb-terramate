module "db" {
  source     = "terraform-aws-modules/rds/aws"
  version    = "6.6.0"
  identifier = "rds"

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t4g.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = 3306

  manage_master_user_password = false
  storage_encrypted           = false

  multi_az               = true
  db_subnet_group_name   = var.database_subnet_group
  vpc_security_group_ids = [ var.vpc_security_group_ids ]

  skip_final_snapshot = true
  deletion_protection = false
}