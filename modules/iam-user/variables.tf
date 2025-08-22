variable "create" {
  description = "Controls if resources should be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# User
################################################################################

variable "name" {
  description = "Desired name for the IAM user"
  type        = string
  default     = ""
}

variable "path" {
  description = "Desired path for the IAM user"
  type        = string
  default     = null
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed"
  type        = bool
  default     = false
}

variable "policies" {
  description = "Policies to attach to the IAM user in `{'static_name' = 'policy_arn'}` format"
  type        = map(string)
  default     = {}
}

################################################################################
# User Login Profile
################################################################################

variable "create_login_profile" {
  description = "Whether to create IAM user login profile"
  type        = bool
  default     = true
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Used to encrypt password and access key"
  type        = string
  default     = null
}

variable "password_length" {
  description = "The length of the generated password"
  type        = number
  default     = null
}

variable "password_reset_required" {
  description = "Whether the user should be forced to reset the generated password on first login"
  type        = bool
  default     = true
}

################################################################################
# Access Key
################################################################################

variable "create_access_key" {
  description = "Whether to create IAM access key"
  type        = bool
  default     = true
}

variable "access_key_status" {
  description = "Access key status to apply"
  type        = string
  default     = null
}

################################################################################
# SSH Key
################################################################################

variable "create_ssh_key" {
  description = "Whether to upload a public ssh key to the IAM user"
  type        = bool
  default     = false
}

variable "ssh_key_encoding" {
  description = "Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM"
  type        = string
  default     = "SSH"
}

variable "ssh_public_key" {
  description = "The SSH public key. The public key must be encoded in ssh-rsa format or PEM format"
  type        = string
  default     = ""
}

################################################################################
# Inline policy
################################################################################

variable "create_inline_policy" {
  description = "Determines whether to create an inline policy"
  type        = bool
  default     = false
}

variable "source_inline_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s"
  type        = list(string)
  default     = []
}

variable "override_inline_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid`"
  type        = list(string)
  default     = []
}

variable "inline_policy_permissions" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for inline policy permissions"
  type = map(object({
    sid           = optional(string)
    actions       = optional(list(string))
    not_actions   = optional(list(string))
    effect        = optional(string, "Allow")
    resources     = optional(list(string))
    not_resources = optional(list(string))
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })))
    not_principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })))
    condition = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })))
  }))
  default = null
}
