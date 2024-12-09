terraform {
  source = "../../../../modules/eks"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
    private_subnets  = [ "fake-subnet-id-1", "fake-subnet-id-2" ]
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  eks_cluster_name       = "bluebird"
  k8s_version            = "1.29"
  vpc_id                 = dependency.vpc.outputs.vpc_id
  subnet_ids             = dependency.vpc.outputs.private_subnets
  control_plane_subnet_ids = dependency.vpc.outputs.private_subnets
  workers_config         = {
    worker = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
      instance_types = ["c3.xlarge"]
      capacity_type  = "SPOT"
    }
  }
  repository_name        = "bluebird-app"
  image_tag_mutability   = "MUTABLE"
  force_delete           = true
  scan_on_push           = true
}