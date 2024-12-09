variable "cluster_name" {
  description = "EKS cluster name"
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
}

# variable "oidc_issuer" {
#   description = "EKS oidc issuer"
# }

variable "node_group_iam_role" {
  description = "EKS node group iam role name"
}

variable "eks_oidc_provider" {
  description = "The OpenID Connect identity provider"
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
}

