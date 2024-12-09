terraform {
  source = "../../../../modules/rds"
}

dependency "mysql_security_group" {
  config_path = "../mysql_security_group"

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
  mock_outputs = {
    security_group_id = "fake-security-group-id"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
  mock_outputs = {
    database_subnet_group  = "fake-database-subnet-group"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 100
  db_name               = "bluebirdhotel"    //needs correction
  username              = "bluebird_user"    //needs correction
  password              = "password"         //needs correction
  port                  = 3306
  vpc_security_group_ids  = dependency.mysql_security_group.outputs.security_group_id
  database_subnet_group   = dependency.vpc.outputs.database_subnet_group
  multi_az               = true
  skip_final_snapshot    = false
  deletion_protection    = true
}