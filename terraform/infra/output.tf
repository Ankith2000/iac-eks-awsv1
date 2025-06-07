output "vpc_id" {
  description = "vpc id"
  value = module.vpc.vpc_id
}

output "cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value = module.eks.cluster_name
}