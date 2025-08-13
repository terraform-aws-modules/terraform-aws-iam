################################################################################
# IAM Group
################################################################################

output "group_id" {
  description = "The group's ID"
  value       = module.iam_group.id
}

output "group_arn" {
  description = "The ARN assigned by AWS for this group"
  value       = module.iam_group.arn
}

output "group_name" {
  description = "The group's name"
  value       = module.iam_group.name
}

output "group_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = module.iam_group.unique_id
}

output "group_users" {
  description = "List of IAM users in IAM group"
  value       = module.iam_group.users
}

output "group_policy_arn" {
  description = "The ARN assigned by AWS for this policy"
  value       = module.iam_group.policy_arn
}

output "group_policy_name" {
  description = "The policy's name"
  value       = module.iam_group.policy_name
}

output "group_policy_id" {
  description = "The policy's ID"
  value       = module.iam_group.policy_id
}
