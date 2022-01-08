resource "aws_iam_policy" "policy" {
  count = var.create_policy ? 1 : 0

  name        = var.name
  path        = var.path
  description = var.description

  policy = data.aws_iam_policy_document.combined.json

  tags = var.tags
}

locals {
  allowed_services = distinct(var.allowed_services)
}

data "aws_iam_policy_document" "allowed_services" {

  dynamic "statement" {
    for_each = toset(local.allowed_services)
    content {
      sid = replace(statement.value, "-", "")

      actions = [
        "${statement.value}:List*",
        "${statement.value}:Get*",
        "${statement.value}:Describe*",
        "${statement.value}:View*",
      ]
      resources = ["*"]
    }
  }
}

data "aws_iam_policy_document" "console_services" {
  count = var.allow_web_console_services ? 1 : 0

  dynamic "statement" {
    for_each = toset(var.web_console_services)
    content {
      sid = replace(statement.value, "-", "")

      actions = [
        "${statement.value}:List*",
        "${statement.value}:Get*",
        "${statement.value}:Describe*",
        "${statement.value}:View*",
      ]
      resources = ["*"]
    }
  }
}

data "aws_iam_policy_document" "sts" {
  count = var.allow_predefined_sts_actions ? 1 : 0

  statement {
    sid = "STS"
    actions = [
      "sts:GetAccessKeyInfo",
      "sts:GetCallerIdentity",
      "sts:GetSessionToken",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "logs_query" {
  count = var.allow_cloudwatch_logs_query ? 1 : 0

  statement {
    sid = "AllowLogsQuery"
    actions = [
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:FilterLogEvents"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = concat(
    [data.aws_iam_policy_document.allowed_services.json],
    data.aws_iam_policy_document.console_services.*.json,
    data.aws_iam_policy_document.sts.*.json,
    data.aws_iam_policy_document.logs_query.*.json,
    [var.additional_policy_json]
  )
}
