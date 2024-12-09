variable "repository_name" {
  type        = string
  description = "The name of the ECR repository"
}

variable "image_tag_mutability" {
  type        = string
  description = "The tag mutability settings for the repository."
}

variable "force_delete" {
  type        = bool
  description = "Specifies whether the repository should be deleted when the Terraform resource is destroyed"
}

variable "scan_on_push" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository"
  default     = true
}