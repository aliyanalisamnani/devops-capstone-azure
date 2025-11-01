resource "kubernetes_namespace" "ns" {
  metadata {
    name = "devops-capstone"

    labels = {
      owner = "student"
      env   = "dev"
    }
  }
}
