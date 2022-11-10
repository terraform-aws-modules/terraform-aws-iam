resource "aws_iam_policy" "deploy_boundary" {
  name = "${var.prefix}-terraform-boundary"
  path = "/${var.namespaces.boundary_namespace}/"

  policy = templatefile("${path.module}/policies/deploy-boundary.json", {
    account_id                 = data.aws_caller_identity.current.account_id
    role_namespace             = var.namespaces.role_namespace
    policy_namespace           = var.namespaces.policy_namespace
    instance_profile_namespace = var.namespaces.instance_profile_namespace
    boundary_namespace         = var.namespaces.boundary_namespace
    permission_boundary        = aws_iam_policy.boundary.arn
    aws_partition              = var.aws_partition
  })
}
