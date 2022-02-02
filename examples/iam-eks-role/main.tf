provider "aws" {
  region = local.region
}

locals {
  name            = "ex-iam-eks-role"
  cluster_version = "1.21"
  region          = "eu-west-1"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-iam"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# AWS IAM EKS Role Module
################################################################################

module "iam_eks_role" {
  source = "../../modules/iam-eks-role"

  role_name = local.name

  cluster_service_accounts = {
    (module.eks.cluster_id) = ["default:my-app", "canary:my-app"]
  }

  provider_url_sa_pairs = {
    "oidc.eks.us-east-1.amazonaws.com/id/5C54DDF35ER19312844C7333374CC09D" = ["default:my-app2"]
    "oidc.eks.ap-southeast-1.amazonaws.com/id/5C54DDF35ER54476848E7333374FF09G" = [
      "default:my-app2",
      "canary:my-app2",
    ]
  }

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]

  tags = local.tags
}

module "cluster_autoscaler_irsa_role" {
  source = "../../modules/iam-eks-role"

  role_name                        = "cluster-autoscaler"
  attach_cluster_autoscaler_policy = true

  cluster_service_accounts = {
    (module.eks.cluster_id) = ["default:my-app", "canary:my-app"]
  }

  tags = local.tags
}

module "external_dns_irsa_role" {
  source = "../../modules/iam-eks-role"

  role_name                  = "external-dns"
  attach_external_dns_policy = true
  external_dns_hosted_zones  = ["IClearlyMadeThisUp"]

  cluster_service_accounts = {
    (module.eks.cluster_id) = ["default:my-app", "canary:my-app"]
  }

  tags = local.tags
}

module "ebs_csi_irsa_role" {
  source = "../../modules/iam-eks-role"

  role_name             = "ebs_csi"
  attach_ebs_csi_policy = true

  cluster_service_accounts = {
    (module.eks.cluster_id) = ["default:my-app", "canary:my-app"]
  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  enable_flow_log                      = true
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }

  tags = local.tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = local.name
  cluster_version = local.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}
