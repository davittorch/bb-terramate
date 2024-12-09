variable "namespace_name" {
  description = "Name of the Kubernetes namespace for external secrets"
  type        = string
}

variable "helm_chart" {
  description = "Helm chart details"
  type = object({
    name       = string
    repository = string
    chart      = string
    set        = map(string)
  })
}
