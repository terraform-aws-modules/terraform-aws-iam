################################################################################
# AWS Gateway Controller Policy
################################################################################

data "aws_iam_policy_document" "aws_gateway_controller" {
  count = var.create && var.attach_aws_gateway_controller_policy ? 1 : 0

  # https://github.com/aws/aws-application-networking-k8s/blob/v1.1.0/files/controller-installation/recommended-inline-policy.json
  statement {
    actions = [
      "vpc-lattice:*",
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeSecurityGroups",
      "logs:CreateLogDelivery",
      "logs:GetLogDelivery",
      "logs:DescribeLogGroups",
      "logs:PutResourcePolicy",
      "logs:DescribeResourcePolicies",
      "logs:UpdateLogDelivery",
      "logs:DeleteLogDelivery",
      "logs:ListLogDeliveries",
      "tag:GetResources",
      "firehose:TagDeliveryStream",
      "s3:GetBucketPolicy",
      "s3:PutBucketPolicy",
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["arn:${local.partition}:iam::*:role/aws-service-role/vpc-lattice.${local.dns_suffix}/AWSServiceRoleForVpcLattice"]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = ["vpc-lattice.${local.dns_suffix}"]
    }
  }

  statement {
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["arn:${local.partition}:iam::*:role/aws-service-role/delivery.logs.${local.dns_suffix}/AWSServiceRoleForLogDelivery"]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = ["delivery.logs.${local.dns_suffix}"]
    }
  }
}

################################################################################
# Cert Manager Policy
################################################################################

# https://cert-manager.io/docs/configuration/acme/dns01/route53/#set-up-an-iam-role
data "aws_iam_policy_document" "cert_manager" {
  count = var.create && var.attach_cert_manager_policy ? 1 : 0

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

################################################################################
# Cluster Autoscaler Policy
################################################################################

# https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md
data "aws_iam_policy_document" "cluster_autoscaler" {
  count = var.create && var.attach_cluster_autoscaler_policy ? 1 : 0

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
      "ec2:DescribeImages",
      "ec2:GetInstanceTypesFromInstanceRequirements"
    ]

    resources = ["*"]
  }

  dynamic "statement" {
    for_each = toset(var.cluster_autoscaler_cluster_names)

    content {
      actions = [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup"
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

################################################################################
# EBS CSI Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/example-iam-policy.json
data "aws_iam_policy_document" "ebs_csi" {
  count = var.create && var.attach_ebs_csi_policy ? 1 : 0

  statement {
    actions = [
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
    actions = [
      "ec2:CreateSnapshot",
      "ec2:ModifyVolume",
    ]

    resources = ["arn:${local.partition}:ec2:*:*:volume/*"]
  }

  statement {
    actions = [
      "ec2:AttachVolume",
      "ec2:DetachVolume",
    ]

    resources = [
      "arn:${local.partition}:ec2:*:*:volume/*",
      "arn:${local.partition}:ec2:*:*:instance/*",
    ]
  }

  statement {
    actions = [
      "ec2:CreateVolume",
      "ec2:EnableFastSnapshotRestores",
    ]

    resources = ["arn:${local.partition}:ec2:*:*:snapshot/*"]
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
    resources = ["arn:${local.partition}:ec2:*:*:volume/*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/ebs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    actions   = ["ec2:CreateVolume"]
    resources = ["arn:${local.partition}:ec2:*:*:volume/*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/CSIVolumeName"
      values   = ["*"]
    }
  }

  statement {
    actions   = ["ec2:DeleteVolume"]
    resources = ["arn:${local.partition}:ec2:*:*:volume/*"]

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/ebs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    actions   = ["ec2:DeleteVolume"]
    resources = ["arn:${local.partition}:ec2:*:*:volume/*"]

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/CSIVolumeName"
      values   = ["*"]
    }
  }

  statement {
    actions   = ["ec2:DeleteVolume"]
    resources = ["arn:${local.partition}:ec2:*:*:volume/*"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/kubernetes.io/created-for/pvc/name"
      values   = ["*"]
    }
  }

  statement {
    actions   = ["ec2:CreateSnapshot"]
    resources = ["arn:${local.partition}:ec2:*:*:snapshot/*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/CSIVolumeSnapshotName"
      values   = ["*"]
    }
  }

  statement {
    actions   = ["ec2:CreateSnapshot"]
    resources = ["arn:${local.partition}:ec2:*:*:snapshot/*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/ebs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    actions   = ["ec2:DeleteSnapshot"]
    resources = ["arn:${local.partition}:ec2:*:*:snapshot/*"]

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/CSIVolumeSnapshotName"
      values   = ["*"]
    }
  }

  statement {
    actions   = ["ec2:DeleteSnapshot"]
    resources = ["arn:${local.partition}:ec2:*:*:snapshot/*"]

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/ebs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  dynamic "statement" {
    for_each = length(var.ebs_csi_kms_cmk_arns) > 0 ? [1] : []

    content {
      actions = [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant",
      ]

      resources = var.ebs_csi_kms_cmk_arns

      condition {
        test     = "Bool"
        variable = "kms:GrantIsForAWSResource"
        values   = [true]
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.ebs_csi_kms_cmk_arns) > 0 ? [1] : []

    content {
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
      ]

      resources = var.ebs_csi_kms_cmk_arns
    }
  }
}

################################################################################
# EFS CSI Driver Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/docs/iam-policy-example.json
data "aws_iam_policy_document" "efs_csi" {
  count = var.create && var.attach_efs_csi_policy ? 1 : 0

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
    actions   = ["elasticfilesystem:TagResource"]
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

################################################################################
# Mountpoint S3 CSI Driver Policy
################################################################################

#https://github.com/awslabs/mountpoint-s3/blob/main/doc/CONFIGURATION.md#iam-permissions
data "aws_iam_policy_document" "mountpoint_s3_csi" {
  count = var.create && var.attach_mountpoint_s3_csi_policy ? 1 : 0

  statement {
    sid       = "MountpointFullBucketAccess"
    actions   = ["s3:ListBucket"]
    resources = coalescelist(var.mountpoint_s3_csi_bucket_arns, ["arn:${local.partition}:s3:::*"])
  }

  statement {
    sid = "MountpointFullObjectAccess"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject"
    ]
    resources = var.mountpoint_s3_csi_path_arns
  }

  dynamic "statement" {
    for_each = length(var.mountpoint_s3_csi_kms_arns) > 0 ? [1] : []

    content {
      actions = [
        "kms:GenerateDataKey",
        "kms:Decrypt"
      ]

      resources = var.mountpoint_s3_csi_kms_arns
    }
  }
}

################################################################################
# External DNS Policy
################################################################################

# https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md#iam-policy
data "aws_iam_policy_document" "external_dns" {
  count = var.create && var.attach_external_dns_policy ? 1 : 0

  statement {
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = var.external_dns_hosted_zone_arns
  }

  statement {
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResources",
    ]

    resources = ["*"]
  }
}

################################################################################
# External Secrets Policy
################################################################################

# https://github.com/external-secrets/external-secrets#add-a-secret
data "aws_iam_policy_document" "external_secrets" {
  count = var.create && var.attach_external_secrets_policy ? 1 : 0

  statement {
    actions   = ["ssm:DescribeParameters"]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = length(var.external_secrets_ssm_parameter_arns) > 0 ? [1] : []

    content {
      actions = [
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath"
      ]

      resources = var.external_secrets_ssm_parameter_arns
    }
  }

  statement {
    actions   = ["secretsmanager:ListSecrets", "secretsmanager:BatchGetSecretValue"]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = length(var.external_secrets_secrets_manager_arns) > 0 ? [1] : []

    content {
      actions = [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
      ]

      resources = var.external_secrets_secrets_manager_arns
    }
  }

  dynamic "statement" {
    for_each = length(var.external_secrets_kms_key_arns) > 0 ? [1] : []

    content {
      actions   = ["kms:Decrypt"]
      resources = var.external_secrets_kms_key_arns
    }
  }

  dynamic "statement" {
    for_each = var.external_secrets_secrets_manager_create_permission ? [1] : []

    content {
      actions = [
        "secretsmanager:CreateSecret",
        "secretsmanager:PutSecretValue",
        "secretsmanager:TagResource",
      ]
      resources = var.external_secrets_secrets_manager_arns
    }
  }

  dynamic "statement" {
    for_each = var.external_secrets_secrets_manager_create_permission ? [1] : []

    content {
      actions   = ["secretsmanager:DeleteSecret"]
      resources = var.external_secrets_secrets_manager_arns

      condition {
        test     = "StringEquals"
        variable = "secretsmanager:ResourceTag/managed-by"
        values   = ["external-secrets"]
      }
    }
  }
}

################################################################################
# FSx for Lustre CSI Driver Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-fsx-csi-driver/blob/master/docs/README.md
data "aws_iam_policy_document" "fsx_lustre_csi" {
  count = var.create && var.attach_fsx_lustre_csi_policy ? 1 : 0

  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:AttachRolePolicy",
      "iam:PutRolePolicy",
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
      "fsx:UpdateFileSystem",
    ]
    resources = ["*"]
  }
}

################################################################################
# FSx for OpenZFS CSI Driver Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-fsx-openzfs-csi-driver/blob/main/docs/install.md
data "aws_iam_policy_document" "fsx_openzfs_csi" {
  count = var.create && var.attach_fsx_openzfs_csi_policy ? 1 : 0

  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:AttachRolePolicy",
      "iam:PutRolePolicy",
    ]
    resources = var.fsx_openzfs_csi_service_role_arns
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
      "fsx:CreateFileSystem",
      "fsx:UpdateFileSystem",
      "fsx:DeleteFileSystem",
      "fsx:DescribeFileSystems",
      "fsx:CreateVolume",
      "fsx:DeleteVolume",
      "fsx:DescribeVolumes",
      "fsx:CreateSnapshot",
      "fsx:DeleteSnapshot",
      "fsx:DescribeSnapshots",
      "fsx:TagResource",
      "fsx:ListTagsForResource",
    ]
    resources = ["*"]
  }
}

################################################################################
# AWS Load Balancer Controller Policy
################################################################################

# https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/main/docs/install/iam_policy.json
data "aws_iam_policy_document" "load_balancer_controller" {
  count = var.create && var.attach_load_balancer_controller_policy ? 1 : 0

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
      "ec2:GetSecurityGroupsForVpc",
      "ec2:DescribeIpamPools",
      "ec2:DescribeRouteTables",
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
      "elasticloadbalancing:DescribeTrustStores",
      "elasticloadbalancing:DescribeListenerAttributes",
      "elasticloadbalancing:DescribeCapacityReservation",
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
    ]
    resources = ["*"]
  }

  statement {
    actions = [
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
      "elasticloadbalancing:ModifyListenerAttributes",
      "elasticloadbalancing:ModifyCapacityReservation",
      "elasticloadbalancing:ModifyIpPools"
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
      "elasticloadbalancing:AddTags"
    ]
    resources = [
      "arn:${local.partition}:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:${local.partition}:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:${local.partition}:elasticloadbalancing:*:*:loadbalancer/app/*/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "elasticloadbalancing:CreateAction"
      values = [
        "CreateTargetGroup",
        "CreateLoadBalancer",
      ]
    }

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
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
      "elasticloadbalancing:SetRulePriorities"
    ]
    resources = ["*"]
  }
}

################################################################################
# AWS Load Balancer Controller TargetGroup Binding Only Policy
################################################################################

# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/targetgroupbinding/targetgroupbinding/#reference
# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/deploy/installation/#setup-iam-manually
data "aws_iam_policy_document" "load_balancer_controller_targetgroup_only" {
  count = var.create && var.attach_load_balancer_controller_targetgroup_binding_only_policy ? 1 : 0

  statement {
    actions = [
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeVpcs",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
    ]

    resources = var.load_balancer_controller_targetgroup_arns
  }
}

################################################################################
# Amazon Managed Service for Prometheus Policy
################################################################################

# https://docs.aws.amazon.com/prometheus/latest/userguide/set-up-irsa.html
data "aws_iam_policy_document" "amazon_managed_service_prometheus" {
  count = var.create && var.attach_amazon_managed_service_prometheus_policy ? 1 : 0

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

################################################################################
# Node Termination Handler Policy
################################################################################

# https://github.com/aws/aws-node-termination-handler#5-create-an-iam-role-for-the-pods
data "aws_iam_policy_document" "node_termination_handler" {
  count = var.create && var.attach_node_termination_handler_policy ? 1 : 0

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

################################################################################
# Velero Policy
################################################################################

# https://github.com/vmware-tanzu/velero-plugin-for-aws#set-permissions-for-velero
data "aws_iam_policy_document" "velero" {
  count = var.create && var.attach_velero_policy ? 1 : 0

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
      "s3:PutObjectTagging",
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

################################################################################
# VPC CNI Policy
################################################################################

data "aws_iam_policy_document" "vpc_cni" {
  count = var.create && var.attach_vpc_cni_policy ? 1 : 0

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
        "ec2:DescribeSubnets",
        "ec2:DetachNetworkInterface",
        "ec2:ModifyNetworkInterfaceAttribute",
        "ec2:UnassignPrivateIpAddresses"
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

  # https://docs.aws.amazon.com/eks/latest/userguide/cni-network-policy.html#cni-network-policy-setup
  dynamic "statement" {
    for_each = var.vpc_cni_enable_cloudwatch_logs ? [1] : []

    content {
      sid = "CloudWatchLogs"
      actions = [
        "logs:DescribeLogGroups",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
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

################################################################################
# Amazon CloudWatch Observability Policy
################################################################################

resource "aws_iam_role_policy_attachment" "amazon_cloudwatch_observability" {
  for_each = { for k, v in {
    CloudWatchAgentServerPolicy = "arn:${local.partition}:iam::aws:policy/CloudWatchAgentServerPolicy"
    AWSXrayWriteOnlyAccess      = "arn:${local.partition}:iam::aws:policy/AWSXrayWriteOnlyAccess"
  } : k => v if var.create && var.attach_cloudwatch_observability_policy }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}
