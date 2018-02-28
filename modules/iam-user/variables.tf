variable "create_user" {
  description = "Whether to create the IAM user"
  default     = true
}

variable "create_iam_user_login_profile" {
  description = "Whether to create IAM user login profile"
  default     = true
}

variable "create_iam_access_key" {
  description = "Whether to create IAM access key"
  default     = true
}

variable "name" {
  description = "Desired name for the IAM user"
}

variable "path" {
  description = "Desired path for the IAM user"
  default     = "/"
}

variable "force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  default     = false
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key."
  default     = ""
}

variable "password_reset_required" {
  description = "Whether the user should be forced to reset the generated password on first login."
  default     = true
}

variable "password_length" {
  description = "The length of the generated password"
  default     = 20
}
