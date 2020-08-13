variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "trusted_role_services" {
  description = "AWS Services that can assume these roles"
  type        = list(string)
  default     = []
}

variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  type        = number
  default     = 86400
}

# Admin
variable "create_admin_role" {
  description = "Whether to create admin role"
  type        = bool
  default     = false
}

variable "admin_role_name" {
  description = "IAM role with admin access"
  type        = string
  default     = "admin"
}

variable "admin_role_path" {
  description = "Path of admin IAM role"
  type        = string
  default     = "/"
}

variable "admin_role_requires_mfa" {
  description = "Whether admin role requires MFA"
  type        = bool
  default     = true
}

variable "admin_role_policy_arns" {
  description = "List of policy ARNs to use for admin role"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

variable "admin_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for admin role"
  type        = string
  default     = ""
}

variable "admin_role_tags" {
  description = "A map of tags to add to admin role resource."
  type        = map(string)
  default     = {}
}

# Poweruser
variable "create_poweruser_role" {
  description = "Whether to create poweruser role"
  type        = bool
  default     = false
}

variable "poweruser_role_name" {
  description = "IAM role with poweruser access"
  type        = string
  default     = "poweruser"
}

variable "poweruser_role_path" {
  description = "Path of poweruser IAM role"
  type        = string
  default     = "/"
}

variable "poweruser_role_requires_mfa" {
  description = "Whether poweruser role requires MFA"
  type        = bool
  default     = true
}

variable "poweruser_role_policy_arns" {
  description = "List of policy ARNs to use for poweruser role"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/PowerUserAccess"]
}

variable "poweruser_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for poweruser role"
  type        = string
  default     = ""
}

variable "poweruser_role_tags" {
  description = "A map of tags to add to poweruser role resource."
  type        = map(string)
  default     = {}
}

# Readonly
variable "create_readonly_role" {
  description = "Whether to create readonly role"
  type        = bool
  default     = false
}

variable "readonly_role_name" {
  description = "IAM role with readonly access"
  type        = string
  default     = "readonly"
}

variable "readonly_role_path" {
  description = "Path of readonly IAM role"
  type        = string
  default     = "/"
}

variable "readonly_role_requires_mfa" {
  description = "Whether readonly role requires MFA"
  type        = bool
  default     = true
}

variable "readonly_role_policy_arns" {
  description = "List of policy ARNs to use for readonly role"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

variable "readonly_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for readonly role"
  type        = string
  default     = ""
}

variable "readonly_role_tags" {
  description = "A map of tags to add to readonly role resource."
  type        = map(string)
  default     = {}
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}

