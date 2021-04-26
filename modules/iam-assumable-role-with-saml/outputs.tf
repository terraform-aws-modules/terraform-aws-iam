output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = element(concat(aws_iam_role.this.*.arn, [""]), 0)
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = element(concat(aws_iam_role.this.*.name, [""]), 0)
}

output "iam_role_path" {
  description = "Path of IAM role"
  value       = element(concat(aws_iam_role.this.*.path, [""]), 0)
}

output "iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = element(concat(aws_iam_role.this.*.unique_id, [""]), 0)
}
