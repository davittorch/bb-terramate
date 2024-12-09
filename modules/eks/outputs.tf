output "cluster_id" {
  value = module.eks.cluster_id
}

output eks_cluster_endpoint {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value     = module.eks.cluster_certificate_authority_data
  sensitive = true
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

output "token" {
  value     = data.aws_eks_cluster_auth.cluster.token
  sensitive = true
}

output "eks_oidc_arn" {
  value       = module.eks.oidc_provider_arn
  description = "The ARN of the OIDC Provider"
}

output "eks_oidc_provider" {
  value       = module.eks.oidc_provider
  description = "The OpenID Connect identity provider"
}

output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS cluster name"
}

output "oidc_issuer" {
  value       = module.eks.cluster_oidc_issuer_url
  description = "EKS oidc issuer"
}

output "node_group_iam_role" {
  value       = module.eks.eks_managed_node_groups.worker.iam_role_name
  description = "EKS node group iam role name"
}

