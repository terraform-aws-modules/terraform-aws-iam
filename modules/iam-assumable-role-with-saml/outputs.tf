output "this_iam_role_arn" {
  description = "ARN of IAM role"
  value       = element(concat(aws_iam_role.this.*.arn, [""]), 0)
}

output "this_iam_role_name" {
  description = "Name of IAM role"
  value       = element(concat(aws_iam_role.this.*.name, [""]), 0)
}

output "this_iam_role_path" {
  description = "Path of IAM role"
  value       = element(concat(aws_iam_role.this.*.path, [""]), 0)
}
