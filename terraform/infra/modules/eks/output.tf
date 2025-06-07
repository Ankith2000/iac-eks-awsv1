output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
  description = "Name of cluster"
  value = aws_eks_cluster.main.name
}