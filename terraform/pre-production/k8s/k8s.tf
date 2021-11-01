resource "kubernetes_namespace" "k" {
  metadata {
    name = "http-echo-tf"
  }
}
resource "kubernetes_deployment" "k" {
  metadata {
    name      = "http-echo-tf"
    namespace = kubernetes_namespace.k.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "wefox-challenge-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "wefox-challenge-app"
        }
      }
      spec {
        container {
          image = "hashicorp/http-echo:${var.image_version}"
          name  = "http-echo-tf-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "k" {
  metadata {
    name      = "http-echo-tf"
    namespace = kubernetes_namespace.k.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.k.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 30060
      port        = 80
      target_port = 80
    }
  }
}