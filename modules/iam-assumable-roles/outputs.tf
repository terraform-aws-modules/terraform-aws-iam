#Admin
output "admin_iam_role_arn" {
  description = "ARN of admin IAM role"
  value       = join("", aws_iam_role.admin.*.arn)
}

output "admin_iam_role_name" {
  description = "Name of admin IAM role"
  value       = join("", aws_iam_role.admin.*.name)
}

output "admin_iam_role_path" {
  description = "Path of admin IAM role"
  value       = join("", aws_iam_role.admin.*.path)
}

output "admin_iam_role_requires_mfa" {
  description = "Whether admin IAM role requires MFA"
  value       = var.admin_role_requires_mfa
}

output "admin_iam_role_trusted_arns" {
  description = "The ARNs trusted to assume the admin role"
  value       = length(var.admin_trusted_role_arns) > 0 ? var.admin_trusted_role_arns : var.trusted_role_arns
}

output "admin_iam_role_trusted_services" {
  description = "The Services trusted to assume the admin role"
  value       = var.use_custom_admin_role_trust ? var.admin_trusted_role_services : var.trusted_role_services
}

# Poweruser
output "poweruser_iam_role_arn" {
  description = "ARN of poweruser IAM role"
  value       = join("", aws_iam_role.poweruser.*.arn)
}

output "poweruser_iam_role_name" {
  description = "Name of poweruser IAM role"
  value       = join("", aws_iam_role.poweruser.*.name)
}

output "poweruser_iam_role_path" {
  description = "Path of poweruser IAM role"
  value       = join("", aws_iam_role.poweruser.*.path)
}

output "poweruser_iam_role_requires_mfa" {
  description = "Whether poweruser IAM role requires MFA"
  value       = var.poweruser_role_requires_mfa
}

output "poweruser_iam_role_trusted_arns" {
  description = "The ARNs trusted to assume the poweruser role"
  value       = length(var.poweruser_trusted_role_arns) > 0 ? var.poweruser_trusted_role_arns : var.trusted_role_arns
}

output "poweruser_iam_role_trusted_services" {
  description = "The Services trusted to assume the poweruser role"
  value       = var.use_custom_poweruser_role_trust ? var.poweruser_trusted_role_services : var.trusted_role_services
}

# Readonly
output "readonly_iam_role_arn" {
  description = "ARN of readonly IAM role"
  value       = join("", aws_iam_role.readonly.*.arn)
}

output "readonly_iam_role_name" {
  description = "Name of readonly IAM role"
  value       = join("", aws_iam_role.readonly.*.name)
}

output "readonly_iam_role_path" {
  description = "Path of readonly IAM role"
  value       = join("", aws_iam_role.readonly.*.path)
}

output "readonly_iam_role_requires_mfa" {
  description = "Whether readonly IAM role requires MFA"
  value       = var.readonly_role_requires_mfa
}

output "readonly_iam_role_trusted_arns" {
  description = "The ARNs trusted to assume the readonly role"
  value       = var.use_custom_readonly_role_trust ? var.readonly_trusted_role_arns : var.trusted_role_arns
}

output "readonly_iam_role_trusted_services" {
  description = "The Services trusted to assume the readonly role"
  value       = var.use_custom_readonly_role_trust ? var.readonly_trusted_role_services : var.trusted_role_services
}

# All roles
output "role_arns" {
  value = {
    admin     = join("", aws_iam_role.admin.*.arn)
    poweruser = join("", aws_iam_role.poweruser.*.arn)
    readonly  = join("", aws_iam_role.readonly.*.arn)
  }
}
