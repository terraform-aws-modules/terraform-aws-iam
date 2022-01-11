provider "aws" {
  region = "eu-west-1"
}

module "iam_eks_role" {
  source    = "../../modules/iam-eks-role"
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
