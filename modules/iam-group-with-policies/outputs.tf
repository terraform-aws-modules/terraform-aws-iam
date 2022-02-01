output "aws_account_id" {
  description = "IAM AWS account id"
  value       = local.aws_account_id
}

output "group_arn" {
  description = "IAM group arn"
  value       = try(aws_iam_group.this[0].arn, "")
}

output "group_users" {
  description = "List of IAM users in IAM group"
  value       = flatten(aws_iam_group_membership.this[*].users)
}

output "group_name" {
  description = "IAM group name"
  value       = try(aws_iam_group.this[0].name, var.name)
}
