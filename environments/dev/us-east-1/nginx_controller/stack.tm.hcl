stack {
  name        = "nginx_controller"
  description = "nginx_controller"
  after       = ["/environments/dev/us-east-1/eks"]
  id          = "89797249-d002-472d-ac30-25c1551bf6be"
}
