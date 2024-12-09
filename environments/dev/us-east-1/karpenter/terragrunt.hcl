# terraform {
#   source = "../../../../modules/karpenter"
# }

# include {
#   path = find_in_parent_folders()
# }

# dependency "eks" {
#   config_path = "../eks"

#   mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
#   mock_outputs = {
#     # eks_oidc_arn = "fake-arn"
#     eks_cluster_name = "fake-name"
#     eks_cluster_endpoint = "fake-endpoint"
#     oidc_issuer = "fake-issuer-url"
#     node_group_iam_role = "fake-role-name"
#     eks_oidc_provider = "fake-oidc-provider"
#     eks_oidc_arn = "fake-oidc-provider-arn"
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

# generate "provider_helm" {
#   path      = "provider_helm.tf"
#   if_exists = "overwrite"
#   contents  = <<-EOF
# provider "helm" {
#   kubernetes {
#     host                   = "${dependency.eks.outputs.eks_cluster_endpoint}"
#     cluster_ca_certificate = base64decode("${dependency.eks.outputs.cluster_certificate_authority_data}")
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", "bluebird", "--output", "json"]
#       command     = "aws"
#     }
#   }
# }
# EOF
# }

# inputs = {
#   cluster_name        = dependency.eks.outputs.eks_cluster_name
#   cluster_endpoint    = dependency.eks.outputs.eks_cluster_endpoint
#   # oidc_issuer         = dependency.eks.outputs.oidc_issuer
#   node_group_iam_role = dependency.eks.outputs.node_group_iam_role
#   eks_oidc_provider   = dependency.eks.outputs.eks_oidc_provider
#   oidc_provider_arn   = dependency.eks.outputs.eks_oidc_arn
# }