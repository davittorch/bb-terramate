variable "vpc_id" {
  description = "The VPC ID where the security group will be created."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The VPC cidr block"
  type        = string
}


# variable "allowed_cidr_blocks" {
#   description = "List of CIDR blocks allowed to access MySQL."
#   type        = list(string)
# }