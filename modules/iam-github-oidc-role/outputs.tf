################################################################################
# GitHub OIDC Role
################################################################################

output "arn" {
  description = "ARN of IAM role"
  value       = try(aws_iam_role.this[0].arn, null)
}

output "name" {
  description = "Name of IAM role"
  value       = try(aws_iam_role.this[0].name, null)
}

output "path" {
  description = "Path of IAM role"
  value       = try(aws_iam_role.this[0].path, null)
}

output "unique_id" {
  description = "Unique ID of IAM role"
  value       = try(aws_iam_role.this[0].unique_id, null)
}

output "assume_role_policy_json" {
  description = "Assume Role Policy JSON document of IAM Role"
  value       = data.aws_iam_policy_document.this.json
}
