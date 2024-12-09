include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/aws_secrets_manager"
}

dependency "rds" {
  config_path = "../rds"

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
  mock_outputs = {
    db_instance_endpoint = "fake-rds-endpoint"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
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
  secret_name        = "secrets"
  secret_description = "RDS credentials for PHP application"
  recovery_window_in_days = 0
  # prevent_destroy = false
  rds_endpoint     = dependency.rds.outputs.db_instance_endpoint
  rds_master_user  = "bluebird_user"
  rds_password     = "password"
  db_name          = "bluebirdhotel"
}