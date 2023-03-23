output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(aws_iam_role.this[0].arn, "")
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = try(aws_iam_role.this[0].name, "")
}

output "iam_role_path" {
  description = "Path of IAM role"
  value       = try(aws_iam_role.this[0].path, "")
}

output "iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = try(aws_iam_role.this[0].unique_id, "")
}

output "iam_role_assume_role_policy_json" {
  description = "Assume Role Policy JSON document of IAM Role"
  value       = data.aws_iam_policy_document.assume_role_with_oidc.json
}
