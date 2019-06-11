variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  default     = []
}

variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  default     = 86400
}

# Admin
variable "create_admin_role" {
  description = "Whether to create admin role"
  default     = false
}

variable "admin_role_name" {
  description = "IAM role with admin access"
  default     = "admin"
}

variable "admin_role_path" {
  description = "Path of admin IAM role"
  default     = "/"
}

variable "admin_role_requires_mfa" {
  description = "Whether admin role requires MFA"
  default     = true
}

variable "admin_role_policy_arns" {
  description = "List of policy ARNs to use for admin role"
  type        = "list"
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

variable "admin_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for admin role"
  default     = ""
}

variable "admin_role_tags" {
  description = "A map of tags to add to admin role resource."
  type        = "map"
  default     = "{}"
}

# Poweruser
variable "create_poweruser_role" {
  description = "Whether to create poweruser role"
  default     = false
}

variable "poweruser_role_name" {
  description = "IAM role with poweruser access"
  default     = "poweruser"
}

variable "poweruser_role_path" {
  description = "Path of poweruser IAM role"
  default     = "/"
}

variable "poweruser_role_requires_mfa" {
  description = "Whether poweruser role requires MFA"
  default     = true
}

variable "poweruser_role_policy_arns" {
  description = "List of policy ARNs to use for poweruser role"
  type        = "list"
  default     = ["arn:aws:iam::aws:policy/PowerUserAccess"]
}

variable "poweruser_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for poweruser role"
  default     = ""
}

variable "poweruser_role_tags" {
  description = "A map of tags to add to power role resource."
  type        = "map"
  default     = "{}"
}

# Readonly
variable "create_readonly_role" {
  description = "Whether to create readonly role"
  default     = false
}

variable "readonly_role_name" {
  description = "IAM role with readonly access"
  default     = "readonly"
}

variable "readonly_role_path" {
  description = "Path of readonly IAM role"
  default     = "/"
}

variable "readonly_role_requires_mfa" {
  description = "Whether readonly role requires MFA"
  default     = true
}

variable "readonly_role_policy_arns" {
  description = "List of policy ARNs to use for readonly role"
  type        = "list"
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

variable "readonly_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for readonly role"
  default     = ""
}

variable "readonly_role_tags" {
  description = "A map of tags to add to readonly role resource."
  type        = "map"
  default     = "{}"
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  default     = 3600
}
