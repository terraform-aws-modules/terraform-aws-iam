################################################################################
# Migrations: v5.60 -> v6.0
################################################################################

moved {
  from = aws_iam_policy.iam_self_management
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_group_policy_attachment.iam_self_management
  to   = aws_iam_group_policy_attachment.this
}
