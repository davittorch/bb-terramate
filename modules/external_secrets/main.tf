resource "helm_release" "external_secrets" {
  name       = var.helm_chart.name
  repository = var.helm_chart.repository
  chart      = var.helm_chart.chart
  namespace  = "external-secrets"

  set {
    name  = "installCRDs"
    value = var.helm_chart.set.installCRDs
  }
}
