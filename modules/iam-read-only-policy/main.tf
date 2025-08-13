################################################################################
# IAM Policy
################################################################################

resource "aws_iam_policy" "policy" {
  count = var.create && var.create_policy ? 1 : 0

  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null
  path        = var.path
  description = var.description
  policy      = data.aws_iam_policy_document.this[0].json

  tags = var.tags
}

data "aws_iam_policy_document" "this" {
  count = var.create ? 1 : 0

  source_policy_documents   = var.source_inline_policy_documents
  override_policy_documents = var.override_inline_policy_documents

  dynamic "statement" {
    for_each = toset(distinct(var.allowed_services))

    content {
      sid = replace(statement.value, "-", "")

      actions = [
        "${statement.value}:List*",
        "${statement.value}:Get*",
        "${statement.value}:BatchGet*",
        "${statement.value}:Describe*",
        "${statement.value}:View*",
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = { for k, v in toset(var.web_console_services) : k => v if var.allow_web_console_services }

    content {
      sid = replace(statement.value, "-", "")

      actions = [
        "${statement.value}:List*",
        "${statement.value}:Get*",
        "${statement.value}:BatchGet*",
        "${statement.value}:Describe*",
        "${statement.value}:View*",
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.allow_predefined_sts_actions ? [1] : []

    content {
      sid = "STS"
      actions = [
        "sts:GetAccessKeyInfo",
        "sts:GetCallerIdentity",
        "sts:GetSessionToken",
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.allow_cloudwatch_logs_query ? [1] : []

    content {
      sid = "AllowLogsQuery"
      actions = [
        "logs:StartQuery",
        "logs:StopQuery",
        "logs:FilterLogEvents"
      ]
      resources = ["*"]
    }
  }
}
