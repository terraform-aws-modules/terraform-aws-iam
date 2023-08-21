provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-irsa"
  region = "eu-west-1"

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
  source = "../../modules/iam-role-for-service-accounts-eks"

  create_role = false
}

module "irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name              = local.name
  allow_self_assume_role = true

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

  role_policy_arns = {
    AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    additional           = aws_iam_policy.additional.arn
  }

  tags = local.tags
}

module "aws_gateway_controller_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                            = "aws-gateway-controller"
  attach_aws_gateway_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["aws-application-networking-system:gateway-api-controller"]
    }
  }

  tags = local.tags
}

module "cert_manager_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                     = "cert-manager"
  attach_cert_manager_policy    = true
  cert_manager_hosted_zone_arns = ["arn:aws:route53:::hostedzone/IClearlyMadeThisUp"]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cert-manager"]
    }
  }

  tags = local.tags
}

module "cluster_autoscaler_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                        = "cluster-autoscaler"
  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_names = [module.eks.cluster_name]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }

  tags = local.tags
}

module "ebs_csi_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name             = "ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = local.tags
}

module "efs_csi_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name             = "efs-csi"
  attach_efs_csi_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:efs-csi-controller-sa"]
    }
  }

  tags = local.tags
}

module "external_dns_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                     = "external-dns"
  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/IClearlyMadeThisUp"]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:external-dns"]
    }
  }

  tags = local.tags
}

module "external_secrets_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                                          = "external-secrets"
  attach_external_secrets_policy                     = true
  external_secrets_ssm_parameter_arns                = ["arn:aws:ssm:*:*:parameter/foo"]
  external_secrets_secrets_manager_arns              = ["arn:aws:secretsmanager:*:*:secret:bar"]
  external_secrets_kms_key_arns                      = ["arn:aws:kms:*:*:key/1234abcd-12ab-34cd-56ef-1234567890ab"]
  external_secrets_secrets_manager_create_permission = false

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["default:kubernetes-external-secrets"]
    }
  }

  tags = local.tags
}

module "fsx_lustre_csi_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                    = "fsx-lustre-csi"
  attach_fsx_lustre_csi_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:fsx-csi-controller-sa"]
    }
  }
}

module "karpenter_controller_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                          = "karpenter-controller"
  attach_karpenter_controller_policy = true

  karpenter_controller_cluster_name       = module.eks.cluster_name
  karpenter_controller_node_iam_role_arns = [module.eks.eks_managed_node_groups["default"].iam_role_arn]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["karpenter:karpenter"]
    }
  }

  tags = local.tags
}

module "load_balancer_controller_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                              = "load-balancer-controller"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }

  tags = local.tags
}

module "load_balancer_controller_targetgroup_binding_only_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                                                       = "load-balancer-controller-targetgroup-binding-only"
  attach_load_balancer_controller_targetgroup_binding_only_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }

  tags = local.tags
}

module "appmesh_controller_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                        = "appmesh-controller"
  attach_appmesh_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["appmesh-system:appmesh-controller"]
    }
  }

  tags = local.tags
}

module "appmesh_envoy_proxy_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                         = "appmesh-envoy-proxy"
  attach_appmesh_envoy_proxy_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["appmesh-system:appmesh-envoy-proxy"]
    }
  }

  tags = local.tags
}

module "amazon_managed_service_prometheus_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                                       = "amazon-managed-service-prometheus"
  attach_amazon_managed_service_prometheus_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["prometheus:amp-ingest"]
    }
  }

  tags = local.tags
}

module "node_termination_handler_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name                              = "node-termination-handler"
  attach_node_termination_handler_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}

module "velero_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name             = "velero"
  attach_velero_policy  = true
  velero_s3_bucket_arns = ["arn:aws:s3:::velero-backups"]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["velero:velero"]
    }
  }

  tags = local.tags
}

module "vpc_cni_ipv4_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name             = "vpc-cni-ipv4"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}

module "vpc_cni_ipv6_irsa_role" {
  source = "../../modules/iam-role-for-service-accounts-eks"

  role_name             = "vpc-cni-ipv6"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv6   = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}

################################################################################
# Custom IRSA Roles
################################################################################

# This is an example of a custom IRSA role which allows workloads with the specified serviceccount to perform actions in a S3 bucket.
module "iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "myapp"
  path        = "/"
  description = "Example policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*",
        ]
        Resource = "*"
      }
    ]
  })

}

module "iam_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "my-app"

  role_policy_arns = {
    policy = module.iam_policy.arn
  }

  oidc_providers = {
    one = {
      provider_arn               = "arn:aws:iam::012345678901:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/5C54DDF35ER19312844C7333374CC09D"
      namespace_service_accounts = ["default:my-app-staging", "canary:my-app-staging"]
    }
    two = {
      provider_arn               = "arn:aws:iam::012345678901:oidc-provider/oidc.eks.ap-southeast-1.amazonaws.com/id/5C54DDF35ER54476848E7333374FF09G"
      namespace_service_accounts = ["default:my-app-staging"]
    }
  }
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

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
  version = "~> 19.14"

  cluster_name    = local.name
  cluster_version = "1.26"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {}
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
