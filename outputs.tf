output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}
  
output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}
