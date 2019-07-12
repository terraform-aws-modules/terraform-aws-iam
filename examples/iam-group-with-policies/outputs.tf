output "iam_account_id" {
  description = "IAM AWS account id"
  value       = module.iam_group_superadmins.aws_account_id
}

output "this_group_users" {
  description = "List of IAM users in IAM group"
  value       = module.iam_group_superadmins.this_group_users
}

output "this_group_name" {
  description = "IAM group name"
  value       = module.iam_group_superadmins.this_group_name
}
