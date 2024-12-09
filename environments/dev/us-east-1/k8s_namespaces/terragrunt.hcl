include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/k8s_namespaces"
}

dependency "eks" {
  config_path = "../eks"

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
  mock_outputs = {
    eks_cluster_endpoint = "fake-host"
    cluster_certificate_authority_data  = "ZmFrZS1jZXJ0aWZpY2F0ZQ=="
    token = "fake-token"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

generate "provider_kubernetes" {
  path      = "provider_kubernetes.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
provider "kubernetes" {
  host                   = "${dependency.eks.outputs.eks_cluster_endpoint}"
  cluster_ca_certificate = base64decode("${dependency.eks.outputs.cluster_certificate_authority_data}")
  exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "bluebird", "--output", "json"]
      command     = "aws"
  }
}
EOF
}

inputs = {
  namespaces = [ "bluebird", "argocd-apps", "external-secrets", "karpenter", "keda" ]
}