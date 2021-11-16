output "id" {
  description = "The policy ID"
  value       = module.iam_policy.policy_object.id
}

output "arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = module.iam_policy.policy_object.arn
}

output "description" {
  description = "The description of the policy"
  value       = module.iam_policy.policy_object.description
}

output "name" {
  description = "The name of the policy"
  value       = module.iam_policy.policy_object.name
}

output "path" {
  description = "The path of the policy in IAM"
  value       = module.iam_policy.policy_object.path
}

output "policy" {
  description = "The policy document"
  value       = module.iam_policy.policy_object.policy
}
