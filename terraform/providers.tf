terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32"
    }
  }
}

provider "kubernetes" {
  # Uses your local kubeconfig (Minikube)
  config_path    = pathexpand("~/.kube/config")
  config_context = "minikube"
}
