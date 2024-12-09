stack {
  name        = "mysql_security_group"
  description = "mysql_security_group"
  after       = ["/environments/dev/us-east-1/vpc"]
  id          = "8ffe8e26-9b3d-494d-8fab-84c09328e40f"
}
