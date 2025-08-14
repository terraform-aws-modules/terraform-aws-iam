provider "aws" {
  region = "eu-west-1"
}

data "aws_availability_zones" "available" {}

locals {
  name = "ex-irsa"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-iam"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# IRSA Roles
################################################################################

module "disabled" {
  source = "../../modules/iam-role-for-service-accounts"

  create = false
}

module "irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = local.name

  oidc_providers = {
    one = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["default:my-app", "canary:my-app"]
    }
    two = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["default:blue", "canary:blue"]
    }
  }

  policies = {
    AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    additional           = aws_iam_policy.additional.arn
  }

  tags = local.tags
}

module "cert_manager_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "cert-manager"

  attach_cert_manager_policy    = true
  cert_manager_hosted_zone_arns = ["arn:aws:route53:::hostedzone/IClearlyMadeThisUp"]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cert-manager"]
    }
  }

  tags = local.tags
}

module "cluster_autoscaler_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "cluster-autoscaler"

  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_names = [module.eks.cluster_name]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }

  tags = local.tags
}

module "ebs_csi_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "ebs-csi"

  attach_ebs_csi_policy = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = local.tags
}

module "efs_csi_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "efs-csi"

  attach_efs_csi_policy = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:efs-csi-controller-sa"]
    }
  }

  tags = local.tags
}

module "mountpoint_s3_csi_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "mountpoint-s3-csi"

  attach_mountpoint_s3_csi_policy = true
  mountpoint_s3_csi_bucket_arns   = ["arn:aws:s3:::mountpoint-s3-csi-bucket"]
  mountpoint_s3_csi_path_arns     = ["arn:aws:s3:::mountpoint-s3-csi-bucket/example/*"]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:s3-csi-driver-sa"]
    }
  }

  tags = local.tags
}

module "external_dns_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "external-dns"

  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/IClearlyMadeThisUp"]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:external-dns"]
    }
  }

  tags = local.tags
}

module "external_secrets_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "external-secrets"

  attach_external_secrets_policy        = true
  external_secrets_ssm_parameter_arns   = ["arn:aws:ssm:*:*:parameter/foo"]
  external_secrets_secrets_manager_arns = ["arn:aws:secretsmanager:*:*:secret:bar"]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["default:kubernetes-external-secrets"]
    }
  }

  tags = local.tags
}

module "fsx_lustre_csi_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "fsx-lustre-csi"

  attach_fsx_lustre_csi_policy = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:fsx-csi-controller-sa"]
    }
  }

  tags = local.tags
}

module "fsx_openzfs_csi_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "fsx-openzfs-csi"

  attach_fsx_openzfs_csi_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:fsx-openzfs-csi-controller-sa"]
    }
  }

  tags = local.tags
}

module "load_balancer_controller_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "load-balancer-controller"

  attach_load_balancer_controller_policy = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }

  tags = local.tags
}

module "load_balancer_controller_targetgroup_binding_only_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "lbc-targetgroup-binding-only"

  attach_load_balancer_controller_targetgroup_binding_only_policy = true
  load_balancer_controller_targetgroup_arns                       = ["arn:aws:elasticloadbalancing:eu-west-1:012345678901:targetgroup/my-target-group"]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }

  tags = local.tags
}

module "amazon_managed_service_prometheus_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "amazon-managed-service-prometheus"

  attach_amazon_managed_service_prometheus_policy  = true
  amazon_managed_service_prometheus_workspace_arns = ["arn:aws:prometheus:eu-west-1:012345678901:workspace/12345678-1234-1234-1234-123456789012"]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["prometheus:amp-ingest"]
    }
  }

  tags = local.tags
}

module "node_termination_handler_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "node-termination-handler"

  attach_node_termination_handler_policy  = true
  node_termination_handler_sqs_queue_arns = ["arn:aws:sqs:eu-west-1:012345678901:node-termination-handler"]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}

module "velero_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "velero"

  attach_velero_policy  = true
  velero_s3_bucket_arns = ["arn:aws:s3:::velero-backups"]

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["velero:velero"]
    }
  }

  tags = local.tags
}

module "vpc_cni_ipv4_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "vpc-cni-ipv4"

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}

module "vpc_cni_ipv6_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "vpc-cni-ipv6"

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv6   = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}

module "cloudwatch_observability_irsa" {
  source = "../../modules/iam-role-for-service-accounts"

  name = "cloudwatch-observability"

  attach_cloudwatch_observability_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["amazon-cloudwatch:cloudwatch-agent"]
    }
  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.name
  kubernetes_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    example = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  tags = local.tags
}

resource "aws_iam_policy" "additional" {
  name        = "${local.name}-additional"
  description = "Additional test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = local.tags
}
