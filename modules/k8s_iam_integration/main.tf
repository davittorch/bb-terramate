resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "SecretsManagerAccessPolicy"
  description = "Policy to allow access to Secrets Manager for Kubernetes pods"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [
          var.aws_secrets_manager_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role" "eks_secrets_role" {
  name = "EKS-SecretsManager-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "${var.eks_oidc_arn}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${var.eks_oidc_provider}:sub": "system:serviceaccount:bluebird:aws-secrets-access"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "secrets_manager_attachment" {
  role       = aws_iam_role.eks_secrets_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

resource "kubernetes_service_account" "external_secrets_sa" {
  metadata {
    name      = "aws-secrets-access"
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks_secrets_role.arn
    }
  }
}