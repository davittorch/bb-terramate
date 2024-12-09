# output "argocd_server_addr" {
#   value = data.kubernetes_service.argocd_server.status.0.load_balancer.0.ingress.0.hostname
# }

output "argocd_admin_password" {
  value = data.kubernetes_secret.argocd_secret.data.password
  description = "The encoded admin password for ArgoCD"
  sensitive = true
}