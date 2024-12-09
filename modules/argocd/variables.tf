variable namespace {
  description = "K8s namespace for argocd"
}

variable argocd_username {
  type        = string
  default     = "admin"
  description = "ArgoCD username"
}