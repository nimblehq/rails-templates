variable "cluster_name" {
  description = "EKS Cluster name"
}

variable "subnets" {
  type = list
}

variable "vpc_id" {
  description = "VPC ID"
}
