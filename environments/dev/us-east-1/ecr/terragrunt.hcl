include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/ecr"
}

inputs = {
  repository_name      = "bluebird"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration = {
    scan_on_push = true
  }
}