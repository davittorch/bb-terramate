output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = [ module.vpc.public_subnets[0], module.vpc.public_subnets[1] ]
}

output "private_subnets" {
  value = [ module.vpc.private_subnets[0], module.vpc.private_subnets[1] ]
}

output "database_subnets" {
  value = [ module.vpc.database_subnets[0], module.vpc.database_subnets[1] ]
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "database_subnet_group" {
  value = module.vpc.database_subnet_group
}