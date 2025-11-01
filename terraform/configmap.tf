resource "kubernetes_config_map" "app_cfg" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.ns.metadata[0].name
  }

  data = {
    APP_NAME = "devops-capstone"
    GREETING = "Hello from Terraform ConfigMap!"
  }
}
