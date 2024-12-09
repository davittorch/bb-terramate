stack {
  name        = "k8s_iam_integration"
  description = "k8s_iam_integration"
  after       = ["/environments/dev/us-east-1/aws_secrets_manager", "/environments/dev/us-east-1/eks"]
  id          = "fb2d831b-b3bb-4a6b-8663-87d26c211a2c"
}
