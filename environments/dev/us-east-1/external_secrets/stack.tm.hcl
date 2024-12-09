stack {
  name        = "external_secrets"
  description = "external_secrets"
  after       = ["/environments/dev/us-east-1/eks"]
  id          = "305acca6-f0a3-453b-9f96-2a9a5ef60141"
}
