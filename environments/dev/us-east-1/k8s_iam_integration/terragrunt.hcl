include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/k8s_iam_integration"
}

dependency "aws_secrets_manager" {
  config_path = "../aws_secrets_manager"

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
  mock_outputs = {
    aws_secrets_manager_arn = "fake-arn"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "eks" {
  config_path = "../eks"

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
  mock_outputs = {
    eks_oidc_arn = "fake-arn"
    eks_oidc_provider = "fake-provider"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  namespace = "bluebird"
  aws_secrets_manager_arn = dependency.aws_secrets_manager.outputs.aws_secrets_manager_arn
  eks_oidc_arn = dependency.eks.outputs.eks_oidc_arn
  eks_oidc_provider = dependency.eks.outputs.eks_oidc_provider
}