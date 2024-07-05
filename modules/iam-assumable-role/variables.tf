variable "trusted_role_actions" {
  description = "Additional trusted role actions"
  type        = list(string)
  default     = ["sts:AssumeRole", "sts:TagSession"]
}

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

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = false
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = bool
  default     = false
}

variable "role_name" {
  description = "IAM role name"
  type        = string
  default     = null
}

variable "role_name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  type        = bool
  default     = true
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}

variable "custom_role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "custom_role_trust_policy" {
  description = "A custom role trust policy. (Only valid if create_custom_role_trust_policy = true)"
  type        = string
  default     = ""
}

variable "create_custom_role_trust_policy" {
  description = "Whether to create a custom_role_trust_policy. Prevent errors with count, when custom_role_trust_policy is computed"
  type        = bool
  default     = false
}

variable "number_of_custom_role_policy_arns" {
  description = "Number of IAM policies to attach to IAM role"
  type        = number
  default     = null
}

variable "inline_policy_statements" {
  description = "List of inline policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) to attach to IAM role as an inline policy"
  type        = any
  default     = []
}

# Pre-defined policies
variable "admin_role_policy_arn" {
  description = "Policy ARN to use for admin role"
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "poweruser_role_policy_arn" {
  description = "Policy ARN to use for poweruser role"
  type        = string
  default     = "arn:aws:iam::aws:policy/PowerUserAccess"
}

variable "readonly_role_policy_arn" {
  description = "Policy ARN to use for readonly role"
  type        = string
  default     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "attach_admin_policy" {
  description = "Whether to attach an admin policy to a role"
  type        = bool
  default     = false
}

variable "attach_poweruser_policy" {
  description = "Whether to attach a poweruser policy to a role"
  type        = bool
  default     = false
}

variable "attach_readonly_policy" {
  description = "Whether to attach a readonly policy to a role"
  type        = bool
  default     = false
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}

variable "role_sts_externalid" {
  description = "STS ExternalId condition values to use with a role (when MFA is not required)"
  type        = any
  default     = []
}

variable "allow_self_assume_role" {
  description = "Determines whether to allow the role to be [assume itself](https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/)"
  type        = bool
  default     = false
}

variable "role_requires_session_name" {
  description = "Determines if the role-session-name variable is needed when assuming a role(https://aws.amazon.com/blogs/security/easily-control-naming-individual-iam-role-sessions/)"
  type        = bool
  default     = false
}

variable "role_session_name" {
  description = "role_session_name for roles which require this parameter when being assumed. By default, you need to set your own username as role_session_name"
  type        = list(string)
  default     = ["$${aws:username}"]
}
