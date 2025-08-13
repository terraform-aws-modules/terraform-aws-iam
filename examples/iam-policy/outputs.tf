################################################################################
# IAM Policy
################################################################################

output "id" {
  description = "The policy ID"
  value       = module.iam_policy.id
}

output "arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = module.iam_policy.arn
}

output "name" {
  description = "The name of the policy"
  value       = module.iam_policy.name
}

output "policy" {
  description = "The policy document"
  value       = module.iam_policy.policy
}
