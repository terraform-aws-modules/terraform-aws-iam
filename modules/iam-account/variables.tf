variable "get_caller_identity" {
  description = "Whether to get AWS account ID, User ID, and ARN in which Terraform is authorized"
  type        = bool
  default     = true
}

variable "account_alias" {
  description = "AWS IAM account alias for this account"
  type        = string
}

variable "create_account_password_policy" {
  description = "Whether to create AWS IAM account password policy"
  type        = bool
  default     = true
}

variable "max_password_age" {
  description = "The number of days that an user password is valid."
  type        = number
  default     = 0
}

variable "minimum_password_length" {
  description = "Minimum length to require for user passwords"
  type        = number
  default     = 8
}

variable "allow_users_to_change_password" {
  description = "Whether to allow users to change their own password"
  type        = bool
  default     = true
}

variable "hard_expiry" {
  description = "Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset)"
  type        = bool
  default     = false
}

variable "password_reuse_prevention" {
  description = "The number of previous passwords that users are prevented from reusing"
  type        = number
  default     = null
}

variable "require_lowercase_characters" {
  description = "Whether to require lowercase characters for user passwords"
  type        = bool
  default     = true
}

variable "require_uppercase_characters" {
  description = "Whether to require uppercase characters for user passwords"
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = "Whether to require numbers for user passwords"
  type        = bool
  default     = true
}

variable "require_symbols" {
  description = "Whether to require symbols for user passwords"
  type        = bool
  default     = true
}
