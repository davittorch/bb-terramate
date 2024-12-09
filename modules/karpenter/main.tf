resource "helm_release" "karpenter" {
  name       = "karpenter"
  namespace  = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  version    = "0.16.2"

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "karpenter"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.karpenter_controller.arn
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "clusterEndpoint"
    value = var.cluster_endpoint
  }

  set {
    name  = "aws.defaultInstanceProfile"
    value = aws_iam_instance_profile.karpenter.name
  }

  set {
    name  = "installCRDs"
    value = true
  }

}

resource "kubectl_manifest" "karpenter_provisioner" {
  yaml_body = <<-YAML
  apiVersion: karpenter.sh/v1alpha5
  kind: Provisioner
  metadata:
    name: default
  spec:
    ttlSecondsAfterEmpty: 60
    ttlSecondsUntilExpired: 86400
    limits:
      resources:
        cpu: "20"
    requirements:
      - key: "karpenter.k8s.aws/instance-family"
        operator: In
        values: ["t3a"]
      - key: "karpenter.k8s.aws/instance-size"
        operator: NotIn
        values: ["nano", "micro", "small", "medium", "large"]
    providerRef:
      name: my-provider
  YAML
}

resource "kubectl_manifest" "aws_node_template" {
  yaml_body = <<-YAML
  apiVersion: karpenter.k8s.aws/v1alpha1
  kind: AWSNodeTemplate
  metadata:
    name: my-provider
  spec:
    subnetSelector:
      "kubernetes.io/cluster/bluebird": "owned"
    securityGroupSelector:
      "kubernetes.io/cluster/bluebird": "owned"
  YAML
}



# ---------------------------------------------------

# data "aws_ecrpublic_authorization_token" "token" {
#   provider = aws.virginia
# }

# module "karpenter" {
#   source  = "terraform-aws-modules/eks/aws//modules/karpenter"
#   version = "~> 20.0"

#   cluster_name = var.cluster_name
#   enable_irsa            = true
#   irsa_oidc_provider_arn = var.oidc_provider_arn
# }

# resource "helm_release" "karpenter" {
#   namespace           = "karpenter"
#   create_namespace    = true
#   name                = "karpenter"
#   repository          = "oci://public.ecr.aws/karpenter"
#   repository_username = data.aws_ecrpublic_authorization_token.token.user_name
#   repository_password = data.aws_ecrpublic_authorization_token.token.password
#   chart               = "karpenter"
#   version             = "0.37.0"
#   wait                = false

#   values = [
#     <<-EOT
#     settings:
#       clusterName: ${var.cluster_name}
#       clusterEndpoint: ${var.cluster_endpoint}
#       interruptionQueue: ${module.karpenter.queue_name}
#     serviceAccount:
#       annotations:
#         eks.amazonaws.com/role-arn: ${module.karpenter.iam_role_arn}
#     controller:
#       affinity:
#         nodeAffinity:
#           requiredDuringSchedulingIgnoredDuringExecution:
#             nodeSelectorTerms:
#             - matchExpressions:
#                 - key: karpenter.sh/nodepool
#                   operator: DoesNotExist
#         podAntiAffinity:
#           requiredDuringSchedulingIgnoredDuringExecution: 
#             topologyKey: ""
#     EOT
#   ]
# }

# resource "kubectl_manifest" "karpenter_node_class" {
#   yaml_body = <<-YAML
#     apiVersion: karpenter.k8s.aws/v1beta1
#     kind: EC2NodeClass
#     metadata:
#       name: default
#     spec:
#       amiFamily: AL2
#       role: ${module.karpenter.node_iam_role_name}
#       subnetSelectorTerms:
#         - tags:
#             karpenter.sh/discovery: ${var.cluster_name}
#       securityGroupSelectorTerms:
#         - tags:
#             karpenter.sh/discovery: ${var.cluster_name}
#       tags:
#         karpenter.sh/discovery: ${var.cluster_name}
#   YAML

#   depends_on = [
#     helm_release.karpenter
#   ]
# }

# resource "kubectl_manifest" "karpenter_node_pool" {
#   yaml_body = <<-YAML
#     apiVersion: karpenter.sh/v1beta1
#     kind: NodePool
#     metadata:
#       name: default
#     spec:
#       template:
#         spec:
#           nodeClassRef:
#             name: default
#           requirements:
#             - key: "karpenter.k8s.aws/instance-family"
#               operator: In
#               values: ["t3a"]
#             - key: "karpenter.k8s.aws/instance-size"
#               operator: NotIn
#               values: ["nano", "micro", "small", "medium"]
#       limits:
#         cpu: 1000
#       disruption:
#         consolidationPolicy: WhenEmpty
#         consolidateAfter: 30s
#   YAML

#   depends_on = [
#     kubectl_manifest.karpenter_node_class
#   ]
# }