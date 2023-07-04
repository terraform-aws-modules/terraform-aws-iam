data "aws_partition" "current" {}

################################################################################
# GitHub OIDC Provider
################################################################################

data "tls_certificate" "this" {
  count = var.create ? 1 : 0

  url = var.url
}

resource "aws_iam_openid_connect_provider" "this" {
  count = var.create ? 1 : 0

  url             = var.url
  client_id_list  = coalescelist(var.client_id_list, ["sts.${data.aws_partition.current.dns_suffix}"])
  thumbprint_list = distinct(concat(data.tls_certificate.this[0].certificates[*].sha1_fingerprint, var.additional_thumbprints))

  tags = var.tags
}
