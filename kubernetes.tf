################################
# Provider
################################
terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "~> 2.1.0"
    }
  }
}


provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

# provider "kubernetes" {
#   config_path    = "c://users//clmachad//.kube//config"
#   config_context = "minikube"
# }

################################
# Resources
################################

# # Create a persistent volume
# resource "kubernetes_persistent_volume" "jenkins-pv" {
#   metadata {
#     name = "jenkins-pv"
#   }
#   spec {
#     capacity = {
#       storage = "20Gi"
#     }
#     access_modes = ["ReadWriteMany"]
#     persistent_volume_source {
#       vsphere_volume {
#         volume_path = "/data/jenkins-volume/"
#       }
#     }
#   }
# }

# Create a namespace
resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = "jenkins"
  }
}


# Create Jenkins deployment
resource "kubernetes_deployment" "jenkins" {
  metadata {
    name = "jenkins"
    namespace = "jenkins"
    labels = {
      App = "jenkins"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "jenkins"
      }
    }
    template {
      metadata {
        labels = {
          App = "jenkins"
        }
      }
      spec {
        container {
          image = "do360now/assessment.devops.images:jenkins_challenge"
          name  = "jenkins"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}


# Create a service account
resource "kubernetes_service" "jenkins" {
  metadata {
    name = "jenkins"
    namespace = "jenkins"
    
  }
  spec {
    selector = {
      App = kubernetes_deployment.jenkins.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 8080
      target_port = 8080
    }

    type = "NodePort"
  }
}

# Create cluster bindings

resource "kubernetes_cluster_role_binding" "jenkins" {
  metadata {
    name = "jenkins"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "admin"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "jenkins"
    namespace = "jenkins"
  }
  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
}