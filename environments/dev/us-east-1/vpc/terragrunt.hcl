terraform {
  source = "../../../../modules/vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_name = "bluebirdhotel-vpc"
  vpc_cidr = "10.0.0.0/16"
}