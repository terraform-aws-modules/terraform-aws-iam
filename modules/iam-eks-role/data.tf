data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_eks_cluster" "main" {
  for_each = var.cluster_service_accounts
  name     = each.key
}
