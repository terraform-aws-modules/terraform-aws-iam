output "this_group_users" {
  description = "List of IAM users in IAM group"
  value       = module.iam_group_complete.this_group_users
}

output "this_assumable_roles" {
  description = "List of ARNs of IAM roles which members of IAM group can assume"
  value       = module.iam_group_complete.this_assumable_roles
}

output "this_policy_arn" {
  description = "Assume role policy ARN for IAM group"
  value       = module.iam_group_complete.this_policy_arn
}
