# include {
#   path = find_in_parent_folders()
# }

# dependency "argocd" {
#   config_path = "../argocd"

#   mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
#   mock_outputs = {
#     argocd_server_addr = "fake-address"
#     argocd_admin_password  = "ZmFrZS1jZXJ0aWZpY2F0ZQ=="
#   }

#   mock_outputs_merge_strategy_with_state = "shallow"
# }

# dependency "eks" {
#   config_path = "../eks"

#   mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
#   mock_outputs = {
#     eks_cluster_endpoint = "fake-host"
#     cluster_certificate_authority_data  = "ZmFrZS1jZXJ0aWZpY2F0ZQ=="
#     token = "fake-token"
#   }

#   mock_outputs_merge_strategy_with_state = "shallow"
# }

# generate "provider_kubernetes" {
#   path      = "provider_kubernetes.tf"
#   if_exists = "overwrite"
#   contents  = <<-EOF
# provider "kubernetes" {
#   host                   = "${dependency.eks.outputs.eks_cluster_endpoint}"
#   cluster_ca_certificate = base64decode("${dependency.eks.outputs.cluster_certificate_authority_data}")
#   exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", "bluebird", "--output", "json"]
#       command     = "aws"
#   }
# }
# EOF
# }

# generate "provider_argocd" {
#   path      = "provider_argocd.tf"
#   if_exists = "overwrite"
#   contents  = <<-EOF
#   provider "argocd" {
#     server_addr = "localhost:8080"
#     username    = "admin"
#     password    = "${dependency.argocd.outputs.argocd_admin_password}"
#     insecure    = true
#   }
#   EOF
# }

# terraform {
#   source = "../../../../modules/argocd_apps"
# }

# inputs = {
#   name      = "argocd-apps"
#   namespace = "argocd-apps"
#   project   = "default"
#   repo_url  = "https://github.com/davittorch/bluebirdhotel-config"
#   path      = "apps"
#   target_revision = "HEAD"
#   destination = {
#     server    = "https://kubernetes.default.svc"
#     namespace = "default"
#   }
#   sync_policy = {
#     automated = {
#       prune       = true
#       self_heal   = true
#       allow_empty = true
#     }
#   }
# }