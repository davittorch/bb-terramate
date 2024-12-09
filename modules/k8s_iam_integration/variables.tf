variable "namespace" {
  description = "K8s namespace for the service account"
}

variable "aws_secrets_manager_arn" {
  description = "Aws secrets manager secret arn"
}

variable "eks_oidc_provider" {
  description = "The OpenID Connect identity provider"
}

variable "eks_oidc_arn" {
  description = "The ARN of the OIDC Provider"
}