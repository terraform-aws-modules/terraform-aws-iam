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

  oidc_providers = {
    one = {
      provider         = module.eks.oidc_provider
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:my-app", "canary:my-app"]
    }
    two = {
      provider         = module.eks.oidc_provider
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:blue", "canary:blue"]
    }
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

  oidc_providers = {
    ex = {
      provider         = module.eks.oidc_provider
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:my-app", "canary:my-app"]
    }
  }

  tags = local.tags
}

module "external_dns_irsa_role" {
  source = "../../modules/iam-eks-role"

  role_name                  = "external-dns"
  attach_external_dns_policy = true
  external_dns_hosted_zones  = ["IClearlyMadeThisUp"]

  oidc_providers = {
    ex = {
      provider         = module.eks.oidc_provider
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:my-app", "canary:my-app"]
    }
  }

  tags = local.tags
}

module "ebs_csi_irsa_role" {
  source = "../../modules/iam-eks-role"

  role_name             = "ebs_csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    ex = {
      provider         = module.eks.oidc_provider
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:my-app", "canary:my-app"]
    }
  }

  tags = local.tags
}

module "vpc_cni_ipv4_irsa_role" {
  source = "../../modules/iam-eks-role"

  role_name             = "vpc_cni_ipv4"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    ex = {
      provider         = module.eks.oidc_provider
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:my-app", "canary:my-app"]
    }
  }

  tags = local.tags
}

module "vpc_cni_ipv6_irsa_role" {
  source = "../../modules/iam-eks-role"

  role_name             = "vpc_cni_ipv6"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv6   = true

  oidc_providers = {
    ex = {
      provider         = module.eks.oidc_provider
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:my-app", "canary:my-app"]
    }
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
  version = "~> 18.6"

  cluster_name    = local.name
  cluster_version = local.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}
