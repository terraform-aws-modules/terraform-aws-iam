data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  dns_suffix = data.aws_partition.current.dns_suffix
}

################################################################################
# Cert Manager Policy
################################################################################

# https://cert-manager.io/docs/configuration/acme/dns01/route53/#set-up-an-iam-role
data "aws_iam_policy_document" "cert_manager" {
  count = var.create_role && var.attach_cert_manager_policy ? 1 : 0

  statement {
    actions   = ["route53:GetChange"]
    resources = ["arn:${local.partition}:route53:::change/*"]
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]

    resources = var.cert_manager_hosted_zone_arns
  }

  statement {
    actions   = ["route53:ListHostedZonesByName"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cert_manager" {
  count = var.create_role && var.attach_cert_manager_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}Cert_Manager_Policy-"
  path        = var.role_path
  description = "Cert Manager policy to allow management of Route53 hosted zone records"
  policy      = data.aws_iam_policy_document.cert_manager[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "cert_manager" {
  count = var.create_role && var.attach_cert_manager_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.cert_manager[0].arn
}

################################################################################
# Cluster Autoscaler Policy
################################################################################

# https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md
data "aws_iam_policy_document" "cluster_autoscaler" {
  count = var.create_role && var.attach_cluster_autoscaler_policy ? 1 : 0

  statement {
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeInstanceTypes",
      "eks:DescribeNodegroup",
    ]

    resources = ["*"]
  }

  dynamic "statement" {
    for_each = toset(var.cluster_autoscaler_cluster_ids)
    content {
      actions = [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "autoscaling:UpdateAutoScalingGroup",
      ]

      resources = ["*"]

      condition {
        test     = "StringEquals"
        variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${statement.value}"
        values   = ["owned"]
      }
    }
  }
}

resource "aws_iam_policy" "cluster_autoscaler" {
  count = var.create_role && var.attach_cluster_autoscaler_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}Cluster_Autoscaler_Policy-"
  path        = var.role_path
  description = "Cluster autoscaler policy to allow examination and modification of EC2 Auto Scaling Groups"
  policy      = data.aws_iam_policy_document.cluster_autoscaler[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  count = var.create_role && var.attach_cluster_autoscaler_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.cluster_autoscaler[0].arn
}

################################################################################
# EBS CSI Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/example-iam-policy.json
data "aws_iam_policy_document" "ebs_csi" {
  count = var.create_role && var.attach_ebs_csi_policy ? 1 : 0

  statement {
    actions = [
      "ec2:CreateSnapshot",
      "ec2:AttachVolume",
      "ec2:DetachVolume",
      "ec2:ModifyVolume",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInstances",
      "ec2:DescribeSnapshots",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
    ]

    resources = ["*"]
  }

  statement {
    actions = ["ec2:CreateTags"]

    resources = [
      "arn:${local.partition}:ec2:*:*:volume/*",
      "arn:${local.partition}:ec2:*:*:snapshot/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values = [
        "CreateVolume",
        "CreateSnapshot",
      ]
    }
  }

  statement {
    actions = ["ec2:DeleteTags"]

    resources = [
      "arn:${local.partition}:ec2:*:*:volume/*",
      "arn:${local.partition}:ec2:*:*:snapshot/*",
    ]
  }

  statement {
    actions   = ["ec2:CreateVolume"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/ebs.csi.aws.com/cluster"
      values = [
        true
      ]
    }
  }

  statement {
    actions   = ["ec2:CreateVolume"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/CSIVolumeName"
      values   = ["*"]
    }
  }

  statement {
    actions   = ["ec2:CreateVolume"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/kubernetes.io/cluster/*"
      values   = ["owned"]
    }
  }

  statement {
    actions   = ["ec2:DeleteVolume"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/ebs.csi.aws.com/cluster"
      values   = [true]
    }
  }

  statement {
    actions   = ["ec2:DeleteVolume"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/CSIVolumeName"
      values   = ["*"]
    }
  }

  statement {
    actions   = ["ec2:DeleteVolume"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/kubernetes.io/cluster/*"
      values   = ["owned"]
    }
  }

  statement {
    actions   = ["ec2:DeleteSnapshot"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/CSIVolumeSnapshotName"
      values   = ["*"]
    }
  }

  statement {
    actions   = ["ec2:DeleteSnapshot"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/ebs.csi.aws.com/cluster"
      values   = [true]
    }
  }

  dynamic "statement" {
    for_each = length(var.ebs_csi_kms_cmk_ids) > 0 ? [1] : []
    content {
      actions = [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant",
      ]

      resources = var.ebs_csi_kms_cmk_ids

      condition {
        test     = "Bool"
        variable = "kms:GrantIsForAWSResource"
        values   = [true]
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.ebs_csi_kms_cmk_ids) > 0 ? [1] : []
    content {
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
      ]

      resources = var.ebs_csi_kms_cmk_ids
    }
  }
}

resource "aws_iam_policy" "ebs_csi" {
  count = var.create_role && var.attach_ebs_csi_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}EBS_CSI_Policy-"
  path        = var.role_path
  description = "Provides permissions to manage EBS volumes via the container storage interface driver"
  policy      = data.aws_iam_policy_document.ebs_csi[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ebs_csi" {
  count = var.create_role && var.attach_ebs_csi_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.ebs_csi[0].arn
}

################################################################################
# EFS CSI Driver Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/docs/iam-policy-example.json
data "aws_iam_policy_document" "efs_csi" {
  count = var.create_role && var.attach_efs_csi_policy ? 1 : 0

  statement {
    actions = [
      "ec2:DescribeAvailabilityZones",
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets",
    ]

    resources = ["*"]
  }

  statement {
    actions   = ["elasticfilesystem:CreateAccessPoint"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    actions   = ["elasticfilesystem:DeleteAccessPoint"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }
}

resource "aws_iam_policy" "efs_csi" {
  count = var.create_role && var.attach_efs_csi_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}EFS_CSI_Policy-"
  path        = var.role_path
  description = "Provides permissions to manage EFS volumes via the container storage interface driver"
  policy      = data.aws_iam_policy_document.efs_csi[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "efs_csi" {
  count = var.create_role && var.attach_efs_csi_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.efs_csi[0].arn
}

################################################################################
# External DNS Policy
################################################################################

# https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md#iam-policy
data "aws_iam_policy_document" "external_dns" {
  count = var.create_role && var.attach_external_dns_policy ? 1 : 0

  statement {
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = var.external_dns_hosted_zone_arns
  }

  statement {
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "external_dns" {
  count = var.create_role && var.attach_external_dns_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}External_DNS_Policy-"
  path        = var.role_path
  description = "External DNS policy to allow management of Route53 hosted zone records"
  policy      = data.aws_iam_policy_document.external_dns[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  count = var.create_role && var.attach_external_dns_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.external_dns[0].arn
}

################################################################################
# External Secrets Policy
################################################################################

# https://github.com/external-secrets/kubernetes-external-secrets#add-a-secret
data "aws_iam_policy_document" "external_secrets" {
  count = var.create_role && var.attach_external_secrets_policy ? 1 : 0

  statement {
    actions   = ["ssm:GetParameter"]
    resources = var.external_secrets_ssm_parameter_arns
  }

  statement {
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
    ]
    resources = var.external_secrets_secrets_manager_arns
  }
}

resource "aws_iam_policy" "external_secrets" {
  count = var.create_role && var.attach_external_secrets_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}External_Secrets_Policy-"
  path        = var.role_path
  description = "Provides permissions to for External Secrets to retrieve secrets from AWS SSM and AWS Secrets Manager"
  policy      = data.aws_iam_policy_document.external_secrets[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "external_secrets" {
  count = var.create_role && var.attach_external_secrets_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.external_secrets[0].arn
}

################################################################################
# FSx for Lustre CSI Driver Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-fsx-csi-driver/blob/master/docs/README.md
data "aws_iam_policy_document" "fsx_lustre_csi" {
  count = var.create_role && var.attach_fsx_lustre_csi_policy ? 1 : 0

  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:AttachRolePolicy",
      "iam:PutRolePolicy"
    ]
    resources = var.fsx_lustre_csi_service_role_arns
  }

  statement {
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = ["fsx.${local.dns_suffix}"]
    }
  }

  statement {
    actions = [
      "s3:ListBucket",
      "fsx:CreateFileSystem",
      "fsx:DeleteFileSystem",
      "fsx:DescribeFileSystems",
      "fsx:TagResource",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "fsx_lustre_csi" {
  count = var.create_role && var.attach_fsx_lustre_csi_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}FSx_Lustre_CSI_Policy-"
  path        = var.role_path
  description = "Provides permissions to manage FSx Lustre volumes via the container storage interface driver"
  policy      = data.aws_iam_policy_document.fsx_lustre_csi[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "fsx_lustre_csi" {
  count = var.create_role && var.attach_fsx_lustre_csi_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.fsx_lustre_csi[0].arn
}

################################################################################
# Karpenter Controller Policy
################################################################################

# curl -fsSL https://karpenter.sh/v0.6.1/getting-started/cloudformation.yaml
data "aws_iam_policy_document" "karpenter_controller" {
  count = var.create_role && var.attach_karpenter_controller_policy ? 1 : 0

  statement {
    actions = [
      "ec2:CreateLaunchTemplate",
      "ec2:CreateFleet",
      "ec2:CreateTags",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInstanceTypeOfferings",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeSpotPriceHistory",
      "pricing:GetProducts",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ec2:TerminateInstances",
      "ec2:DeleteLaunchTemplate",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/${var.karpenter_tag_key}"
      values   = [var.karpenter_controller_cluster_id]
    }
  }

  statement {
    actions = ["ec2:RunInstances"]
    resources = [
      "arn:${local.partition}:ec2:*:${local.account_id}:launch-template/*",
      "arn:${local.partition}:ec2:*:${local.account_id}:security-group/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/${var.karpenter_tag_key}"
      values   = [var.karpenter_controller_cluster_id]
    }
  }

  statement {
    actions = ["ec2:RunInstances"]
    resources = [
      "arn:${local.partition}:ec2:*::image/*",
      "arn:${local.partition}:ec2:*:${local.account_id}:instance/*",
      "arn:${local.partition}:ec2:*:${local.account_id}:volume/*",
      "arn:${local.partition}:ec2:*:${local.account_id}:network-interface/*",
      "arn:${local.partition}:ec2:*:${coalesce(var.karpenter_subnet_account_id, local.account_id)}:subnet/*",
    ]
  }

  statement {
    actions   = ["ssm:GetParameter"]
    resources = var.karpenter_controller_ssm_parameter_arns
  }

  statement {
    actions   = ["iam:PassRole"]
    resources = var.karpenter_controller_node_iam_role_arns
  }
}

resource "aws_iam_policy" "karpenter_controller" {
  count = var.create_role && var.attach_karpenter_controller_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}Karpenter_Controller_Policy-"
  path        = var.role_path
  description = "Provides permissions to handle node termination events via the Node Termination Handler"
  policy      = data.aws_iam_policy_document.karpenter_controller[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "karpenter_controller" {
  count = var.create_role && var.attach_karpenter_controller_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.karpenter_controller[0].arn
}

################################################################################
# AWS Load Balancer Controller Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/main/docs/install/iam_policy.json
data "aws_iam_policy_document" "load_balancer_controller" {
  count = var.create_role && var.attach_load_balancer_controller_policy ? 1 : 0

  statement {
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values   = ["elasticloadbalancing.${local.dns_suffix}"]
    }
  }

  statement {
    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeTags",
      "ec2:GetCoipPoolUsage",
      "ec2:DescribeCoipPools",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeTags",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "cognito-idp:DescribeUserPoolClient",
      "acm:ListCertificates",
      "acm:DescribeCertificate",
      "iam:ListServerCertificates",
      "iam:GetServerCertificate",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "shield:GetSubscriptionState",
      "shield:DescribeProtection",
      "shield:CreateProtection",
      "shield:DeleteProtection",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["ec2:CreateTags"]
    resources = ["arn:${local.partition}:ec2:*:*:security-group/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values   = ["CreateSecurityGroup"]
    }

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]
    resources = ["arn:${local.partition}:ec2:*:*:security-group/*"]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["true"]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
    ]
    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    actions = [
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
    ]
    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    actions = [
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:DeleteRule",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
    ]
    resources = [
      "arn:${local.partition}:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:${local.partition}:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:${local.partition}:elasticloadbalancing:*:*:loadbalancer/app/*/*",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["true"]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
    ]
    resources = [
      "arn:${local.partition}:elasticloadbalancing:*:*:listener/net/*/*/*",
      "arn:${local.partition}:elasticloadbalancing:*:*:listener/app/*/*/*",
      "arn:${local.partition}:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
      "arn:${local.partition}:elasticloadbalancing:*:*:listener-rule/app/*/*/*",
    ]
  }

  statement {
    actions = [
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:DeleteTargetGroup",
    ]
    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    actions = [
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
    ]
    resources = ["arn:${local.partition}:elasticloadbalancing:*:*:targetgroup/*/*"]
  }

  statement {
    actions = [
      "elasticloadbalancing:SetWebAcl",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:ModifyRule",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "load_balancer_controller" {
  count = var.create_role && var.attach_load_balancer_controller_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}AWS_Load_Balancer_Controller-"
  path        = var.role_path
  description = "Provides permissions for AWS Load Balancer Controller addon"
  policy      = data.aws_iam_policy_document.load_balancer_controller[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "load_balancer_controller" {
  count = var.create_role && var.attach_load_balancer_controller_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.load_balancer_controller[0].arn
}

################################################################################
# AWS Load Balancer Controller TargetGroup Binding Only Policy
################################################################################

# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/targetgroupbinding/targetgroupbinding/#reference
# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/deploy/installation/#setup-iam-manually
data "aws_iam_policy_document" "load_balancer_controller_targetgroup_only" {
  count = var.create_role && var.attach_load_balancer_controller_targetgroup_binding_only_policy ? 1 : 0

  statement {
    actions = [
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeVpcs",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "load_balancer_controller_targetgroup_only" {
  count = var.create_role && var.attach_load_balancer_controller_targetgroup_binding_only_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}AWS_Load_Balancer_Controller_TargetGroup_Only-"
  path        = var.role_path
  description = "Provides permissions for AWS Load Balancer Controller addon in TargetGroup binding only scenario"
  policy      = data.aws_iam_policy_document.load_balancer_controller_targetgroup_only[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "load_balancer_controller_targetgroup_only" {
  count = var.create_role && var.attach_load_balancer_controller_targetgroup_binding_only_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.load_balancer_controller_targetgroup_only[0].arn
}

################################################################################
# Appmesh Controller
################################################################################
# https://github.com/aws/eks-charts/tree/master/stable/appmesh-controller#prerequisites
# https://raw.githubusercontent.com/aws/aws-app-mesh-controller-for-k8s/master/config/iam/controller-iam-policy.json
data "aws_iam_policy_document" "appmesh_controller" {
  count = var.create_role && var.attach_appmesh_controller_policy ? 1 : 0

  statement {
    actions = [
      "appmesh:ListVirtualRouters",
      "appmesh:ListVirtualServices",
      "appmesh:ListRoutes",
      "appmesh:ListGatewayRoutes",
      "appmesh:ListMeshes",
      "appmesh:ListVirtualNodes",
      "appmesh:ListVirtualGateways",
      "appmesh:DescribeMesh",
      "appmesh:DescribeVirtualRouter",
      "appmesh:DescribeRoute",
      "appmesh:DescribeVirtualNode",
      "appmesh:DescribeVirtualGateway",
      "appmesh:DescribeGatewayRoute",
      "appmesh:DescribeVirtualService",
      "appmesh:CreateMesh",
      "appmesh:CreateVirtualRouter",
      "appmesh:CreateVirtualGateway",
      "appmesh:CreateVirtualService",
      "appmesh:CreateGatewayRoute",
      "appmesh:CreateRoute",
      "appmesh:CreateVirtualNode",
      "appmesh:UpdateMesh",
      "appmesh:UpdateRoute",
      "appmesh:UpdateVirtualGateway",
      "appmesh:UpdateVirtualRouter",
      "appmesh:UpdateGatewayRoute",
      "appmesh:UpdateVirtualService",
      "appmesh:UpdateVirtualNode",
      "appmesh:DeleteMesh",
      "appmesh:DeleteRoute",
      "appmesh:DeleteVirtualRouter",
      "appmesh:DeleteGatewayRoute",
      "appmesh:DeleteVirtualService",
      "appmesh:DeleteVirtualNode",
      "appmesh:DeleteVirtualGateway"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = ["arn:${local.partition}:iam::*:role/aws-service-role/appmesh.${local.dns_suffix}/AWSServiceRoleForAppMesh"]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = ["appmesh.${local.dns_suffix}"]
    }
  }

  statement {
    actions = [
      "acm:ListCertificates",
      "acm:DescribeCertificate",
      "acm-pca:DescribeCertificateAuthority",
      "acm-pca:ListCertificateAuthorities"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "servicediscovery:CreateService",
      "servicediscovery:DeleteService",
      "servicediscovery:GetService",
      "servicediscovery:GetInstance",
      "servicediscovery:RegisterInstance",
      "servicediscovery:DeregisterInstance",
      "servicediscovery:ListInstances",
      "servicediscovery:ListNamespaces",
      "servicediscovery:ListServices",
      "servicediscovery:GetInstancesHealthStatus",
      "servicediscovery:UpdateInstanceCustomHealthStatus",
      "servicediscovery:GetOperation",
      "route53:GetHealthCheck",
      "route53:CreateHealthCheck",
      "route53:UpdateHealthCheck",
      "route53:ChangeResourceRecordSets",
      "route53:DeleteHealthCheck"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "appmesh_controller" {
  count = var.create_role && var.attach_appmesh_controller_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}Appmesh_Controller-"
  path        = var.role_path
  description = "Provides permissions to for appmesh controller"
  policy      = data.aws_iam_policy_document.appmesh_controller[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "appmesh_controller" {
  count = var.create_role && var.attach_appmesh_controller_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.appmesh_controller[0].arn
}

################################################################################
# Appmesh envoy proxy
################################################################################
# https://github.com/aws/aws-app-mesh-controller-for-k8s/blob/f4a551399c4a4428d31692d0e6d944c2b78f2753/config/helm/appmesh-controller/README.md#with-irsa
# https://raw.githubusercontent.com/aws/aws-app-mesh-controller-for-k8s/master/config/iam/envoy-iam-policy.json
data "aws_iam_policy_document" "appmesh_envoy_proxy" {
  count = var.create_role && var.attach_appmesh_envoy_proxy_policy ? 1 : 0

  statement {
    actions = [
      "appmesh:StreamAggregatedResources"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "acm:ExportCertificate",
      "acm-pca:GetCertificateAuthorityCertificate"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "appmesh_envoy_proxy" {
  count = var.create_role && var.attach_appmesh_envoy_proxy_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}Appmesh_Envoy_Proxy-"
  path        = var.role_path
  description = "Provides permissions to for appmesh envoy proxy"
  policy      = data.aws_iam_policy_document.appmesh_envoy_proxy[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "appmesh_envoy_proxy" {
  count = var.create_role && var.attach_appmesh_envoy_proxy_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.appmesh_envoy_proxy[0].arn
}

################################################################################
# Amazon Managed Service for Prometheus Policy
################################################################################

# https://docs.aws.amazon.com/prometheus/latest/userguide/set-up-irsa.html
data "aws_iam_policy_document" "amazon_managed_service_prometheus" {
  count = var.create_role && var.attach_amazon_managed_service_prometheus_policy ? 1 : 0

  statement {
    actions = [
      "aps:RemoteWrite",
      "aps:QueryMetrics",
      "aps:GetSeries",
      "aps:GetLabels",
      "aps:GetMetricMetadata",
    ]

    resources = var.amazon_managed_service_prometheus_workspace_arns
  }
}

resource "aws_iam_policy" "amazon_managed_service_prometheus" {
  count = var.create_role && var.attach_amazon_managed_service_prometheus_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}Managed_Service_Prometheus_Policy-"
  path        = var.role_path
  description = "Provides permissions to for Amazon Managed Service for Prometheus"
  policy      = data.aws_iam_policy_document.amazon_managed_service_prometheus[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "amazon_managed_service_prometheus" {
  count = var.create_role && var.attach_amazon_managed_service_prometheus_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.amazon_managed_service_prometheus[0].arn
}

################################################################################
# Node Termination Handler Policy
################################################################################

# https://github.com/aws/aws-node-termination-handler#5-create-an-iam-role-for-the-pods
data "aws_iam_policy_document" "node_termination_handler" {
  count = var.create_role && var.attach_node_termination_handler_policy ? 1 : 0

  statement {
    actions = [
      "autoscaling:CompleteLifecycleAction",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeTags",
      "ec2:DescribeInstances",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
    ]

    resources = var.node_termination_handler_sqs_queue_arns
  }
}

resource "aws_iam_policy" "node_termination_handler" {
  count = var.create_role && var.attach_node_termination_handler_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}Node_Termination_Handler_Policy-"
  path        = var.role_path
  description = "Provides permissions to handle node termination events via the Node Termination Handler"
  policy      = data.aws_iam_policy_document.node_termination_handler[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "node_termination_handler" {
  count = var.create_role && var.attach_node_termination_handler_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.node_termination_handler[0].arn
}

################################################################################
# Velero Policy
################################################################################

# https://github.com/vmware-tanzu/velero-plugin-for-aws#set-permissions-for-velero
data "aws_iam_policy_document" "velero" {
  count = var.create_role && var.attach_velero_policy ? 1 : 0

  statement {
    sid = "Ec2ReadWrite"
    actions = [
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot",
    ]
    resources = ["*"]
  }

  statement {
    sid = "S3ReadWrite"
    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
    ]
    resources = [for bucket in var.velero_s3_bucket_arns : "${bucket}/*"]
  }

  statement {
    sid = "S3List"
    actions = [
      "s3:ListBucket",
    ]
    resources = var.velero_s3_bucket_arns
  }
}

resource "aws_iam_policy" "velero" {
  count = var.create_role && var.attach_velero_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}Velero_Policy-"
  path        = var.role_path
  description = "Provides Velero permissions to backup and restore cluster resources"
  policy      = data.aws_iam_policy_document.velero[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "velero" {
  count = var.create_role && var.attach_velero_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.velero[0].arn
}

################################################################################
# VPC CNI Policy
################################################################################

data "aws_iam_policy_document" "vpc_cni" {
  count = var.create_role && var.attach_vpc_cni_policy ? 1 : 0

  # arn:${local.partition}:iam::aws:policy/AmazonEKS_CNI_Policy
  dynamic "statement" {
    for_each = var.vpc_cni_enable_ipv4 ? [1] : []
    content {
      sid = "IPV4"
      actions = [
        "ec2:AssignPrivateIpAddresses",
        "ec2:AttachNetworkInterface",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:DescribeTags",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeInstanceTypes",
        "ec2:DetachNetworkInterface",
        "ec2:ModifyNetworkInterfaceAttribute",
        "ec2:UnassignPrivateIpAddresses",
      ]
      resources = ["*"]
    }
  }

  # https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html#cni-iam-role-create-ipv6-policy
  dynamic "statement" {
    for_each = var.vpc_cni_enable_ipv6 ? [1] : []
    content {
      sid = "IPV6"
      actions = [
        "ec2:AssignIpv6Addresses",
        "ec2:DescribeInstances",
        "ec2:DescribeTags",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeInstanceTypes",
      ]
      resources = ["*"]
    }
  }

  statement {
    sid       = "CreateTags"
    actions   = ["ec2:CreateTags"]
    resources = ["arn:${local.partition}:ec2:*:*:network-interface/*"]
  }
}

resource "aws_iam_policy" "vpc_cni" {
  count = var.create_role && var.attach_vpc_cni_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}CNI_Policy-"
  path        = var.role_path
  description = "Provides the Amazon VPC CNI Plugin (amazon-vpc-cni-k8s) the permissions it requires to modify the IPv4/IPv6 address configuration on your EKS worker nodes"
  policy      = data.aws_iam_policy_document.vpc_cni[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "vpc_cni" {
  count = var.create_role && var.attach_vpc_cni_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.vpc_cni[0].arn
}
