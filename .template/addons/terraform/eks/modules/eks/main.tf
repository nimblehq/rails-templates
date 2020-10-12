module "eks" {
  cluster_version = "1.17"
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  subnets         = var.subnets

  vpc_id = var.vpc_id

  worker_groups = [
    {
      name                 = "worker-group-1"
      instance_type        = "t2.small"
      asg_desired_capacity = 2
    },
    {
      name                 = "worker-group-2"
      instance_type        = "t2.small"
      asg_desired_capacity = 1
    },
  ]

  workers_additional_policies = [aws_iam_policy.worker_policy.arn]
}

resource "aws_iam_policy" "worker_policy" {
  name        = "worker-policy"
  description = "Worker policy for the ALB Ingress"

  policy = file("iam-policy.json")
}
