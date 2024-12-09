stack {
  name        = "argocd"
  description = "argocd"
  after       = ["/environments/dev/us-east-1/eks", "/environments/dev/us-east-1/k8s_namespaces"]
  id          = "56db74d4-12e8-4465-8ad4-47e4701f2afe"
}
