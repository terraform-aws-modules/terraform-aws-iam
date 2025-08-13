################################################################################
# IAM Policy
################################################################################

output "id" {
  description = "The policy's ID"
  value       = try(aws_iam_policy.policy[0].id, null)
}

output "arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = try(aws_iam_policy.policy[0].arn, null)
}

output "name" {
  description = "The name of the policy"
  value       = try(aws_iam_policy.policy[0].name, null)
}

output "policy" {
  description = "The policy document"
  value       = try(aws_iam_policy.policy[0].policy, null)
}
