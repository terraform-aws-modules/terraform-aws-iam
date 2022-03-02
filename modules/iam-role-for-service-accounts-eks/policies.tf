data "aws_partition" "current" {}

locals {
  partition  = data.aws_partition.current.partition
  dns_suffix = data.aws_partition.current.dns_suffix
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
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeInstanceTypes",
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

  name_prefix = "AmazonEKS_Cluster_Autoscaler_Policy-"
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

  name_prefix = "AmazonEKS_External_DNS_Policy-"
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

      resources = statement.value

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

      resources = statement.value
    }
  }
}

resource "aws_iam_policy" "ebs_csi" {
  count = var.create_role && var.attach_ebs_csi_policy ? 1 : 0

  name_prefix = "AmazonEKS_EBS_CSI_Policy-"
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
# VPC CNI Policy
################################################################################

data "aws_iam_policy_document" "vpc_cni" {
  count = var.create_role && var.attach_vpc_cni_policy ? 1 : 0

  # arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
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

  name_prefix = "AmazonEKS_CNI_Policy-"
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

  name_prefix = "AmazonEKS_Node_Termination_Handler_Policy-"
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
      "ec2:DescribeInstances",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInstanceTypeOfferings",
      "ec2:DescribeAvailabilityZones",
    ]

    resources = ["*"]
  }

  dynamic "statement" {
    for_each = toset(var.karpenter_controller_cluster_ids)
    content {
      actions = [
        "ec2:RunInstances",
        "ec2:TerminateInstances",
        "ec2:DeleteLaunchTemplate",
      ]

      resources = ["*"]

      condition {
        test     = "StringEquals"
        variable = "ec2:ResourceTag/karpenter.sh/discovery"
        values   = [statement.value]
      }
    }
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

  name_prefix = "AmazonEKS_Karpenter_Controller_Policy-"
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

  name_prefix = "AmazonEKS_AWS_Load_Balancer_Controller-"
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
