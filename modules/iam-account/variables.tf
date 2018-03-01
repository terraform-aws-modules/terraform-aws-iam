variable "get_caller_identity" {
  description = "Whether to get AWS account ID, User ID, and ARN in which Terraform is authorized"
  default     = true
}

variable "account_alias" {
  description = "AWS IAM account alias for this account"
}

variable "create_account_password_policy" {
  description = "Whether to create AWS IAM account password policy"
  default     = true
}

variable "max_password_age" {
  description = "The number of days that an user password is valid."
  default     = 0
}

variable "minimum_password_length" {
  description = "Minimum length to require for user passwords"
  default     = 8
}

variable "allow_users_to_change_password" {
  description = "Whether to allow users to change their own password"
  default     = true
}

variable "hard_expiry" {
  description = "Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset)"
  default     = false
}

variable "password_reuse_prevention" {
  description = "The number of previous passwords that users are prevented from reusing"
  default     = true
}

variable "require_lowercase_characters" {
  description = "Whether to require lowercase characters for user passwords"
  default     = true
}

variable "require_uppercase_characters" {
  description = "Whether to require uppercase characters for user passwords"
  default     = true
}

variable "require_numbers" {
  description = "Whether to require numbers for user passwords"
  default     = true
}

variable "require_symbols" {
  description = "Whether to require symbols for user passwords"
  default     = true
}
