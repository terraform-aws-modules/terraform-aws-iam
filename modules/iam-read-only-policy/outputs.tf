output "policy_object" {
  description = "Policy object if created"
  value       = one(aws_iam_policy.policy[*])
}

output "policy_json" {
  description = "Policy document as json. Useful if you need document but do not want to create policy itself"
  value       = data.aws_iam_policy_document.combined.json
}
