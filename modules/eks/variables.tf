variable "eks_cluster_name" {
  description = "EKS cluster name"
}

variable "k8s_version" {
  description = "Kubernetes version"
}

variable "vpc_id" {
  description = "VPC ID where the cluster will be created"
}

variable "subnet_ids" {
  description = "Subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "workers_config" {
  description = "Configuration for EKS worker nodes"
  type        = map(any)
}

variable "repository_name" {
  description = "ECR repository name"
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting for the ECR repository"
}

variable "force_delete" {
  description = "Whether to force delete the ECR repository"
}

variable "scan_on_push" {
  description = "Enable image scanning on push for the ECR repository"
}

variable control_plane_subnet_ids {
  description = "Control plane subnet ids"
  type        = list(string)
}