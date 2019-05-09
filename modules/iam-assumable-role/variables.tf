variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  default     = []
}

variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  default     = 86400
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  default     = 3600
}

variable "create_role" {
  description = "Whether to create a role"
  default     = false
}

variable "role_name" {
  description = "IAM role name"
  default     = ""
}

variable "role_path" {
  description = "Path of IAM role"
  default     = "/"
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  default     = true
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  default     = ""
}

variable "custom_role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  default     = []
}

# Pre-defined policies
variable "admin_role_policy_arn" {
  description = "Policy ARN to use for admin role"
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "poweruser_role_policy_arn" {
  description = "Policy ARN to use for poweruser role"
  default     = "arn:aws:iam::aws:policy/PowerUserAccess"
}

variable "readonly_role_policy_arn" {
  description = "Policy ARN to use for readonly role"
  default     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "attach_admin_policy" {
  description = "Whether to attach an admin policy to a role"
  default     = false
}

variable "attach_poweruser_policy" {
  description = "Whether to attach a poweruser policy to a role"
  default     = false
}

variable "attach_readonly_policy" {
  description = "Whether to attach a readonly policy to a role"
  default     = false
}
