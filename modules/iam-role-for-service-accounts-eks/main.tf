data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id          = data.aws_caller_identity.current.account_id
  partition           = data.aws_partition.current.partition
  dns_suffix          = data.aws_partition.current.dns_suffix
  region              = data.aws_region.current.name
  role_name_condition = var.role_name != null ? var.role_name : "${var.role_name_prefix}*"
  default_description = var.attach_external_dns_policy ? "Provides OIDC provider access to Route53" :
                        var.attach_aws_gateway_controller_policy ? "Provides OIDC provider access to AWS Gateway Controller" :
                        var.attach_cert_manager_policy ? "Provides OIDC provider access to Cert Manager" :
                        var.attach_cluster_autoscaler_policy ? "Provides OIDC provider access to Cluster Autoscaler" :
                        var.attach_ebs_csi_policy ? "Provides OIDC provider access to EBS CSI" :
                        var.attach_efs_csi_policy ? "Provides OIDC provider access to EFS CSI" :
                        var.attach_external_secrets_policy ? "Provides OIDC provider access to Secrets Manager" :
                        var.attach_fsx_lustre_csi_policy ? "Provides OIDC provider access to FSX" :
                        var.attach_karpenter_controller_policy ? "Provides Karpenter access to EC2" :
                        var.attach_load_balancer_controller_policy ? "Provides OIDC provider access to EC2 and Load Balancing" :
                        var.attach_appmesh_controller_policy ? "Provides OIDC provider access to Appmesh, ACM, Service Discovery, and Route53" :
                        var.attach_appmesh_envoy_proxy_policy ? "Provides OIDC provider access to Appmesh and ACM" :
                        var.attach_amazon_managed_service_prometheus_policy ? "Provides OIDC provider access to APS" :
                        var.attach_velero_policy ? "Provides OIDC provider access to EC2 and S3" :
                        var.attach_vpc_cni_policy ? "Provides OIDC provider access to EC2" :
                        var.attach_node_termination_handler_policy ? "Provides OIDC provider access to EC2 and SQS" :
                        var.attach_cloudwatch_observability_policy ? "Provides OIDC provider access to CloudWatch and Xray" :
                        null
  role_description    = var.role_description == null ? local.default_description : var.role_description
}

data "aws_iam_policy_document" "this" {
  count = var.create_role ? 1 : 0

  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role ? [1] : []

    content {
      sid     = "ExplicitSelfRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.role_path}${local.role_name_condition}"]
      }
    }
  }

  dynamic "statement" {
    for_each = var.oidc_providers

    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [statement.value.provider_arn]
      }

      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:sub"
        values   = [for sa in statement.value.namespace_service_accounts : "system:serviceaccount:${sa}"]
      }

      # https://aws.amazon.com/premiumsupport/knowledge-center/eks-troubleshoot-oidc-and-irsa/?nc1=h_ls
      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:aud"
        values   = ["sts.amazonaws.com"]
      }

    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name        = var.role_name
  name_prefix = var.role_name_prefix
  path        = var.role_path
  description = local.role_description

  assume_role_policy    = data.aws_iam_policy_document.this[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.role_policy_arns : k => v if var.create_role }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}
