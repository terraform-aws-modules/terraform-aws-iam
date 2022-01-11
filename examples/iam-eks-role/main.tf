provider "aws" {
  region = "eu-west-1"
}

module "iam_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-eks-role"
  version   = "~> 4"
  role_name = "my-app"

  cluster_service_accounts = {
    "cluster1" = ["default:my-app"]
    "cluster2" = [
      "default:my-app",
      "canary:my-app",
    ]
  }

  tags = {
    Name = "eks-role"
  }

  role_policy_arns = [
    "arn:aws:iam::aws:policy/",
  ]
}
