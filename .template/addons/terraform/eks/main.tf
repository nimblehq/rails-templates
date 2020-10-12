provider "aws" {
  version = ">= 2.28.1"
  region  = var.region
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

locals {
  cluster_name = "${var.app_name}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "alb" {
  source = "./modules/alb"

  cluster_name           = local.cluster_name
  cluster_endpoint       = data.aws_eks_cluster.cluster.endpoint
  cluster_auth_token     = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = data.aws_eks_cluster.cluster.certificate_authority.0.data
}

module "eks" {
  source = "./modules/eks"

  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets
  vpc_id       = module.vpc.vpc_id
}

module "vpc" {
  source = "./modules/vpc"

  cluster_name = local.cluster_name
  app_name     = var.app_name
}

module "db" {
  source = "./modules/rds"

  name      = var.rds_db_name
  namespace = var.app_name

  username = var.rds_username
  password = var.rds_password

  ingress_source_security_group_id = module.eks.worker_security_group_id
  egress_source_security_group_id  = module.eks.worker_security_group_id
  vpc_id                           = module.vpc.vpc_id
  subnet_ids                       = module.vpc.private_subnets
}
