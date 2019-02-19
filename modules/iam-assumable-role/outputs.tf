output "this_iam_role_arn" {
  description = "ARN of IAM role"
  value       = "${element(concat(aws_iam_role.this.*.arn, list("")), 0)}"
}

output "this_iam_role_name" {
  description = "Name of IAM role"
  value       = "${element(concat(aws_iam_role.this.*.name, list("")), 0)}"
}

output "this_iam_role_path" {
  description = "Path of IAM role"
  value       = "${element(concat(aws_iam_role.this.*.path, list("")), 0)}"
}

output "role_requires_mfa" {
  description = "Whether IAM role requires MFA"
  value       = "${var.role_requires_mfa}"
}
