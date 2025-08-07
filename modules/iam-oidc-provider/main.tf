data "aws_partition" "current" {
  count = var.create ? 1 : 0
}

locals {
  dns_suffix = try(data.aws_partition.current[0].dns_suffix, "")
}

################################################################################
# OIDC Provider
################################################################################

data "tls_certificate" "this" {
  count = var.create ? 1 : 0

  url = var.url
}

resource "aws_iam_openid_connect_provider" "this" {
  count = var.create ? 1 : 0

  url             = var.url
  client_id_list  = coalescelist(var.client_id_list, ["sts.${local.dns_suffix}"])
  thumbprint_list = data.tls_certificate.this[0].certificates[*].sha1_fingerprint

  tags = var.tags
}
