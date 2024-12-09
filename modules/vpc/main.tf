locals {
  cluster_name = "bluebirdhotel"

  vpc_name = "${local.cluster_name}-vpc"
  region   = "us-east-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = local.vpc_name
  cidr = local.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  azs              = local.azs
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 3)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 6)]

  public_subnet_tags = {
    "kubernetes.io/cluster/bluebird" = "owned"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/bluebird" = "owned"
  }

  default_security_group_tags = {
    "kubernetes.io/cluster/bluebird" = "owned"
  }

  create_database_subnet_group = true

  enable_nat_gateway = true
  single_nat_gateway = true

  create_igw       = true
  instance_tenancy = "default"
}