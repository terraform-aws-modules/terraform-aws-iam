################################################################################
# IAM Policy
################################################################################

output "id" {
  description = "The policy's ID"
  value       = module.read_only_iam_policy.id
}

output "arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = module.read_only_iam_policy.arn
}

output "name" {
  description = "The name of the policy"
  value       = module.read_only_iam_policy.name
}

output "policy" {
  description = "The policy document"
  value       = module.read_only_iam_policy.policy
}

output "policy_json" {
  description = "Policy document JSON"
  value       = module.read_only_iam_policy.policy_json
}
