variable "provider_name" {
  description = "Name of the SAML Provider"
}

variable "provider_id" {
  description = "ID of the SAML Provider"
}

variable "aws_saml_endpoint" {
  description = "AWS SAML Endpoint"
  default     = ["https://signin.aws.amazon.com/saml"]
  type        = "list"
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

variable "admin_role_policy_arn" {
  description = "Policy ARN to use for admin role"
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "admin_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for admin role"
  default     = ""
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

variable "poweruser_role_policy_arn" {
  description = "Policy ARN to use for poweruser role"
  default     = "arn:aws:iam::aws:policy/PowerUserAccess"
}

variable "poweruser_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for poweruser role"
  default     = ""
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

variable "readonly_role_policy_arn" {
  description = "Policy ARN to use for readonly role"
  default     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "readonly_role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for readonly role"
  default     = ""
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  default     = 3600
}
