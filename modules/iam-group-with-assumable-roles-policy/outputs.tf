output "this_group_users" {
  description = "List of IAM users in IAM group"
  value       = flatten(aws_iam_group_membership.this.*.users)
}

output "this_assumable_roles" {
  description = "List of ARNs of IAM roles which members of IAM group can assume"
  value       = var.assumable_roles
}

output "this_policy_arn" {
  description = "Assume role policy ARN of IAM group"
  value       = aws_iam_policy.this.arn
}

output "group_name" {
  description = "IAM group name"
  value       = aws_iam_group.this.name
}

