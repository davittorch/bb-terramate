stack {
  name        = "rds"
  description = "rds"
  after       = ["/environments/dev/us-east-1/mysql_security_group", "/environments/dev/us-east-1/vpc"]
  id          = "ecd7c37c-b4ba-40cb-8419-0c7059275d0d"
}
