resource "kubernetes_namespace" "this" {
  count = length(var.namespaces)

  metadata {
    name = var.namespaces[count.index]
  }
}