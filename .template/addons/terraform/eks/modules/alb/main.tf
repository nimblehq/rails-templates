provider "helm" {
  version = "1.3.1"

  kubernetes {
    load_config_file       = false
    host                   = var.cluster_endpoint
    token                  = var.cluster_auth_token
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  load_config_file       = false
  host                   = var.cluster_endpoint
  token                  = var.cluster_auth_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

resource "helm_release" "ingress" {
  name       = "ingress"
  chart      = "aws-alb-ingress-controller"
  repository = "http://storage.googleapis.com/kubernetes-charts-incubator"
  version    = "1.0.2"

  set {
    name  = "autoDiscoverAwsRegion"
    value = "true"
  }

  set {
    name  = "autoDiscoverAwsVpcID"
    value = "true"
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
}
