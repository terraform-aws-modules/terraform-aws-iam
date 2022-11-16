data "aws_partition" "current" {}

locals {
  github_token_url = "token.actions.githubusercontent.com"
}

################################################################################
# GitHub OIDC Provider
################################################################################

data "tls_certificate" "this" {
  count = var.create ? 1 : 0

  url = "https://${local.github_token_url}"
}

resource "aws_iam_openid_connect_provider" "this" {
  count = var.create ? 1 : 0

  url             = "https://${local.github_token_url}"
  client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
  thumbprint_list = data.tls_certificate.this[0].certificates[*].sha1_fingerprint

  tags = var.tags
}
