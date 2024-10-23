################################################################################
# CircleCI OIDC Provider
################################################################################

resource "aws_iam_openid_connect_provider" "this" {
  count = var.create ? 1 : 0

  url             = "${var.base_url}/${var.org_uuid}"
  client_id_list  = [var.org_uuid]
  thumbprint_list = var.thumbprints

  tags = var.tags
}
