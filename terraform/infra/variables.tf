variable "aws_region" {
  description = "Region of AWS"
  type = string
  default = "ap-south-1"
}

variable "aws_vpc" {
    description = "cidr block of vpc"
    type = string
    default = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  description = "cidr allocations"
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}

variable "az_for_private_subnet" {
    description = "AVailibility zones"
    type = list(string)
   default = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]  
}

variable "public_subnet_cidrs" {
  description = "cidr allocations"
  type = list(string)
  default = [ "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24" ]
}

variable "az_for_public_subnet" {
    description = "AVailibility zones"
    type = list(string)
   default = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]  
}

variable "cluster_name" {
  description = "Name of cluster"
  type = string
  default = "anki-cluster"
}

variable "cluster_version" {
  description = "Version of cluster"
  type = string
  default = "1.32"  
   }

   variable "node_groups" {
     description = "EKS node group configuration"
     type = map(object({
       instance_type = list(string)
       capacity_type = string
       scaling_config = object({
         desired_size = number
         max_size = number
         min_size = number
       })
     }))
         
    default = {
      "eks_nodes" = {
        instance_type = [ "t2.micro" ]
        capacity_type = "ON_DEMAND"
        scaling_config = {
           desired_size = 3
           max_size = 5
           min_size = 2

        }
      }
    }
   }