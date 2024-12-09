resource "argocd_application" "app_of_apps" {

  # depends_on = [ null_resource.wait_for_argocd ]

  metadata {
    name      = "argocd-apps"
    namespace = "argocd-apps"
  }

  spec {
    project = "default"

    source {
      repo_url        = "https://github.com/davittorch/bluebirdhotel-config"
      path            = "apps"
      target_revision = "HEAD"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }

    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
    }
  }
}

# resource "null_resource" "wait_for_argocd" {
#   provisioner "local-exec" {
#     command = <<EOT
#     while ! kubectl get svc -n argocd-apps argocd-server -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' | grep -m 1 '^[a-zA-Z0-9]'; do
#       echo "Waiting for ArgoCD server endpoint..."
#       sleep 10
#     done
#     EOT
#     environment = {
#       KUBECONFIG = "/home/torch/.kube/config"
#     }
#     interpreter = ["/bin/sh", "-c"]
#   }
# }