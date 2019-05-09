locals {
  admin_additional_policies     = "${length(var.admin_role_additional_policies_arn)}"
  poweruser_additional_policies = "${length(var.poweruser_role_additional_policies_arn)}"
  readonly_additional_policies  = "${length(var.readonly_role_additional_policies_arn)}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${var.trusted_role_arns}"]
    }
  }
}

data "aws_iam_policy_document" "assume_role_with_mfa" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${var.trusted_role_arns}"]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = ["${var.mfa_age}"]
    }
  }
}

# Admin
resource "aws_iam_role" "admin" {
  count = "${var.create_admin_role ? 1 : 0}"

  name                 = "${var.admin_role_name}"
  path                 = "${var.admin_role_path}"
  max_session_duration = "${var.max_session_duration}"

  permissions_boundary = "${var.admin_role_permissions_boundary_arn}"

  assume_role_policy = "${var.admin_role_requires_mfa ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "admin" {
  count = "${var.create_admin_role ? 1 : 0}"

  role       = "${aws_iam_role.admin.name}"
  policy_arn = "${var.admin_role_policy_arn}"
}

resource "aws_iam_role_policy_attachment" "admin_additional_policies" {
  count = "${var.create_admin_role && local.admin_additional_policies > 0 ? 1 * local.admin_additional_policies  : 0}"

  role       = "${aws_iam_role.admin.name}"
  policy_arn = "${element(var.admin_role_additional_policies_arn, count.index)}"
}

# Poweruser
resource "aws_iam_role_policy_attachment" "poweruser" {
  count = "${var.create_poweruser_role ? 1 : 0}"

  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "${var.poweruser_role_policy_arn}"
}

resource "aws_iam_role_policy_attachment" "poweruser_additional_policies" {
  count = "${var.create_poweruser_role && local.poweruser_additional_policies > 0 ? 1 * local.poweruser_additional_policies  : 0}"

  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "${element(var.poweruser_role_additional_policies_arn, count.index)}"
}

resource "aws_iam_role" "poweruser" {
  count = "${var.create_poweruser_role ? 1 : 0}"

  name                 = "${var.poweruser_role_name}"
  path                 = "${var.poweruser_role_path}"
  max_session_duration = "${var.max_session_duration}"

  permissions_boundary = "${var.poweruser_role_permissions_boundary_arn}"

  assume_role_policy = "${var.poweruser_role_requires_mfa ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json}"
}

# Readonly
resource "aws_iam_role_policy_attachment" "readonly" {
  count = "${var.create_readonly_role ? 1 : 0}"

  role       = "${aws_iam_role.readonly.name}"
  policy_arn = "${var.readonly_role_policy_arn}"
}

resource "aws_iam_role_policy_attachment" "readonly_additional_policies" {
  count = "${var.create_readonly_role && local.readonly_additional_policies > 0 ? 1 * local.readonly_additional_policies  : 0}"

  role       = "${aws_iam_role.readonly.name}"
  policy_arn = "${element(var.readonly_role_additional_policies_arn, count.index)}"
}

resource "aws_iam_role" "readonly" {
  count = "${var.create_readonly_role ? 1 : 0}"

  name                 = "${var.readonly_role_name}"
  path                 = "${var.readonly_role_path}"
  max_session_duration = "${var.max_session_duration}"

  permissions_boundary = "${var.readonly_role_permissions_boundary_arn}"

  assume_role_policy = "${var.readonly_role_requires_mfa ?  data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json}"
}
