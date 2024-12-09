stack {
  name        = "aws_secrets_manager"
  description = "aws_secrets_manager"
  after       = ["/environments/dev/us-east-1/eks", "/environments/dev/us-east-1/rds"]
  id          = "fb6386ed-2f37-480e-bf20-5d835bf232e4"
}
