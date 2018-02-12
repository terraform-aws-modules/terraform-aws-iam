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
  name = "${var.admin_role_name}"
  path = "${var.admin_role_path}"

  assume_role_policy = "${var.admin_role_requires_mfa ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = "${aws_iam_role.admin.name}"
  policy_arn = "${var.admin_role_policy_arn}"
}

# Poweruser
resource "aws_iam_role_policy_attachment" "poweruser" {
  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "${var.poweruser_role_policy_arn}"
}

resource "aws_iam_role" "poweruser" {
  name = "${var.poweruser_role_name}"
  path = "${var.poweruser_role_path}"

  assume_role_policy = "${var.poweruser_role_requires_mfa ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json}"
}

# Readonly
resource "aws_iam_role_policy_attachment" "readonly" {
  role       = "${aws_iam_role.readonly.name}"
  policy_arn = "${var.readonly_role_policy_arn}"
}

resource "aws_iam_role" "readonly" {
  name = "${var.readonly_role_name}"
  path = "${var.readonly_role_path}"

  assume_role_policy = "${var.readonly_role_requires_mfa ?  data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json}"
}
