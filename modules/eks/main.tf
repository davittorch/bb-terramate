module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.9.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.k8s_version

  vpc_id                                   = var.vpc_id
  authentication_mode                      = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  control_plane_subnet_ids = var.control_plane_subnet_ids

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  subnet_ids = var.subnet_ids

  iam_role_additional_policies = {
    SecretsManagerReadWrite = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  }

  eks_managed_node_groups = var.workers_config
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region us-east-1 update-kubeconfig --name bluebird --profile intern"
  }

  depends_on = [ module.eks ]
}