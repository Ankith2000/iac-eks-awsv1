variable "aws_vpc" {
  description = "value of the VPC CIDR block"
  type = string
}

variable "cluster_name" {
  description="Name of thwe cluster"
  type = string
  default = "otel-cluster"
}   

variable "private_subnet_cidrs" {
  description = "CIDR Block for private subnets"
  type = list(string)
}

variable "az_for_private_subnet" {
  description = "CIDR Block for private subnets"
  type = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR Block for private subnets"
  type = list(string)
}

variable "az_for_public_subnet" {
  description = "CIDR Block for private subnets"
  type = list(string)
}