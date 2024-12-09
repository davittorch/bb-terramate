resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.24.1"
  namespace  = var.namespace

  set {
    name  = "server.service.type"
    value = "ClusterIP"
  }
}

data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = "argocd-apps"
  }

  depends_on = [ helm_release.argocd ]
}

data "kubernetes_secret" "argocd_secret" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd-apps"
  }

  depends_on = [ helm_release.argocd ]
}