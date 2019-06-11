output "iam_account_id" {
  description = "IAM AWS account id (this code is managing resources in this account)"
  value       = data.aws_caller_identity.iam.account_id
}

output "production_account_id" {
  description = "Production AWS account id"
  value       = data.aws_caller_identity.production.account_id
}

output "this_group_users" {
  description = "List of IAM users in IAM group"
  value       = module.iam_group_with_assumable_roles_policy_production_readonly.this_group_users
}

output "this_assumable_roles" {
  description = "List of ARNs of IAM roles which members of IAM group can assume"
  value       = module.iam_group_with_assumable_roles_policy_production_readonly.this_assumable_roles
}

output "this_policy_arn" {
  description = "Assume role policy ARN for IAM group"
  value       = module.iam_group_with_assumable_roles_policy_production_readonly.this_policy_arn
}
