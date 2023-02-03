locals {
  url = "https://api.bitbucket.org/2.0/workspaces/${var.workspace}/pipelines-config/identity/oidc"
}

data "aws_partition" "current" {}

################################################################################
# Bitbucket OIDC Provider
################################################################################

data "tls_certificate" "this" {
  count = var.create ? 1 : 0

  url = local.url
}

resource "aws_iam_openid_connect_provider" "this" {
  count = var.create ? 1 : 0

  url             = local.url
  client_id_list  = coalescelist(var.client_id_list, ["sts.${data.aws_partition.current.dns_suffix}"])
  thumbprint_list = data.tls_certificate.this[0].certificates[*].sha1_fingerprint

  tags = var.tags
}
