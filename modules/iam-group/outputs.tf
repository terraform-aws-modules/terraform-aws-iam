################################################################################
# IAM Group
################################################################################

output "id" {
  description = "The group's ID"
  value       = try(aws_iam_group.this[0].id, null)
}

output "arn" {
  description = "The ARN assigned by AWS for this group"
  value       = try(aws_iam_group.this[0].arn, null)
}

output "name" {
  description = "The group's name"
  value       = try(aws_iam_group.this[0].name, null)
}

output "unique_id" {
  description = " The unique ID assigned by AWS"
  value       = try(aws_iam_group.this[0].unique_id, null)
}

output "users" {
  description = "List of IAM users in IAM group"
  value       = flatten(aws_iam_group_membership.this[*].users)
}

################################################################################
# IAM Group Policy
################################################################################

output "policy_arn" {
  description = "The ARN assigned by AWS for this policy"
  value       = try(aws_iam_policy.this[0].arn, null)
}

output "policy_name" {
  description = "The policy's name"
  value       = try(aws_iam_policy.this[0].name, null)
}

output "policy_id" {
  description = "The policy's ID"
  value       = try(aws_iam_policy.this[0].id, null)
}
