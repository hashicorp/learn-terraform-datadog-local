# # Kubernetes provider
# # https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/terraform/kubernetes/deploy-nginx-kubernetes

provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}


resource "kubernetes_namespace" "beacon" {
  metadata {
    name = "beacon"
  }
}

resource "kubernetes_deployment" "beacon" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.beacon.id
    labels = {
      app = var.application_name
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.application_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.application_name
        }
      }

      spec {
        container {
          image = "onlydole/beacon:datadog"
          name  = var.application_name
        }
      }
    }
  }
}

resource "kubernetes_service" "beacon" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.beacon.id
  }
  spec {
    selector = {
      app = kubernetes_deployment.beacon.metadata[0].labels.app
    }
    port {
      port        = 8080
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

output "beacon_endpoint" {
  value = kubernetes_service.beacon.load_balancer_ingress
}
