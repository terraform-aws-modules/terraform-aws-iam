################################################################################
# IAM Role
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

################################################################################
# IAM Policy
################################################################################

output "iam_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = try(aws_iam_policy.this[0].arn, null)
}

output "iam_policy" {
  description = "The policy document"
  value       = try(aws_iam_policy.this[0].policy, null)
}

################################################################################
# EFS CSI Driver Roles (v3 split)
################################################################################

output "efs_csi_controller_iam_role_arn" {
  description = "ARN of the EFS CSI controller IAM role"
  value       = try(aws_iam_role.efs_csi_controller[0].arn, null)
}

output "efs_csi_controller_iam_role_name" {
  description = "Name of the EFS CSI controller IAM role"
  value       = try(aws_iam_role.efs_csi_controller[0].name, null)
}

output "efs_csi_node_iam_role_arn" {
  description = "ARN of the EFS CSI node IAM role"
  value       = try(aws_iam_role.efs_csi_node[0].arn, null)
}

output "efs_csi_node_iam_role_name" {
  description = "Name of the EFS CSI node IAM role"
  value       = try(aws_iam_role.efs_csi_node[0].name, null)
}
