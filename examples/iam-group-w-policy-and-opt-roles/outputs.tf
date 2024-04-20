output "group_users" {
  description = "List of IAM users in IAM group"
  value       = module.iam_group_with_custom_policy.group_users
}

output "assumable_roles" {
  description = "List of ARNs of IAM roles which members of IAM group can assume"
  value       = module.iam_group_optional_assumable_roles.assumable_roles
}

output "policy_arn" {
  description = "Assume role policy ARN for IAM group"
  value       = module.iam_group_optional_assumable_roles.policy_arn
}
