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

  provider_url_sa_pairs = {
    "oidc.eks.us-east-1.amazonaws.com/id/5C54DDF35ER19312844C7333374CC09D" = ["default:my-app2"]
    "oidc.eks.ap-southeast-1.amazonaws.com/id/5C54DDF35ER54476848E7333374FF09G" = [
      "default:my-app2",
      "canary:my-app2",
    ]
  }

  tags = {
    Name = "eks-role"
  }

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]
}
