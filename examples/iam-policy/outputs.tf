output "id" {
  description = "The policy ID"
  value       = module.iam_policy.id
}

output "arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = module.iam_policy.arn
}

output "description" {
  description = "The description of the policy"
  value       = module.iam_policy.description
}

output "name" {
  description = "The name of the policy"
  value       = module.iam_policy.name
}

output "path" {
  description = "The path of the policy in IAM"
  value       = module.iam_policy.path
}

output "policy" {
  description = "The policy document"
  value       = module.iam_policy.policy
}
