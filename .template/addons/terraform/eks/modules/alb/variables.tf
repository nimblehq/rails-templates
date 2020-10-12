variable "cluster_name" {
  description = "EKS Cluster name"
}
variable "load_config_file" {
  default = false
}

variable "cluster_endpoint" {
  description = "Cluster endpoint"
}

variable "cluster_auth_token" {
  description = "Cluster auth token"
}

variable "cluster_ca_certificate" {
  description = "Cluster CA certificate"
}
