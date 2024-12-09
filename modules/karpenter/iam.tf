data "aws_iam_policy_document" "karpenter_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${var.eks_oidc_provider}:sub"
      values   = ["system:serviceaccount:karpenter:karpenter"]
    }

    principals {
      identifiers = [var.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "karpenter_controller" {
  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume_role_policy.json
  name               = "karpenter-controller"
}

resource "aws_iam_policy" "karpenter_controller" {
  policy = file("./controller-trust-policy.json")
  name   = "KarpenterController"
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_attach" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = aws_iam_policy.karpenter_controller.arn
}

resource "aws_iam_instance_profile" "karpenter" {
  name = "KarpenterNodeInstanceProfile"
  role = var.node_group_iam_role
}


# locals {
#   tags = {
#     Example    = "karpenter"
#     GithubRepo = "terraform-aws-eks"
#     GithubOrg  = "terraform-aws-modules"
#   }
# }

# data "aws_iam_policy_document" "karpenter_sqs_policy_doc" {
#   statement {
#     actions = [
#       "sqs:SendMessage",
#       "sqs:ReceiveMessage",
#       "sqs:DeleteMessage",
#       "sqs:GetQueueAttributes"
#     ]
#     effect = "Allow"
#     resources = [
#       "${module.karpenter.queue_arn}"
#     ]
#   }
# }

# resource "aws_iam_policy" "karpenter_sqs_policy" {
#   name   = "karpenter-sqs-policy"
#   policy = data.aws_iam_policy_document.karpenter_sqs_policy_doc.json
# }

# module "karpenter" {
#   source = "terraform-aws-modules/eks/aws//modules/karpenter"

#   cluster_name = var.cluster_name

#   enable_pod_identity             = true
#   create_pod_identity_association = true

#   node_iam_role_additional_policies = {
#     AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
#     KarpenterSQSPolicy           = aws_iam_policy.karpenter_sqs_policy.arn
#   }

#   tags = local.tags
# }