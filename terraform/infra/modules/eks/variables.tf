variable "cluster_name" {
  description = "Name of the cluster"
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "cluster_version" {
  description = "K8s version"
  type = string
}

variable "subnet_ids" {
  description = "subnets ids"
  type = list(string)
}

variable "node_groups" {
  description = "EKS node groups"
  type = map(object({
    instance_type = list(string)
    capacity_type = string
    scaling_config = object({
      desired_size = number
      max_size = number
      min_size = number 
    })
  }))
}