variable "create" {
  description = "Controls if resources should be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to the resources created"
  type        = map(any)
  default     = {}
}

################################################################################
# GitHub OIDC Role
################################################################################

variable "name" {
  description = "Name of IAM role"
  type        = string
  default     = null
}

variable "path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = null
}

variable "description" {
  description = "IAM Role description"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "policies" {
  description = "Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format"
  type        = map(string)
  default     = {}
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = null
}

variable "audience" {
  description = "Audience to use for OIDC role. Defaults to `sts.amazonaws.com` for use with the [official AWS GitHub action](https://github.com/aws-actions/configure-aws-credentials)"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "subjects" {
  description = "List of GitHub OIDC subjects that are permitted by the trust policy. You do not need to prefix with `repo:` as this is provided. Example: `['my-org/my-repo:*', 'octo-org/octo-repo:ref:refs/heads/octo-branch']`"
  type        = list(string)
  default     = []
}

variable "provider_url" {
  description = "The URL of the identity provider. Corresponds to the iss claim"
  type        = string
  default     = "token.actions.githubusercontent.com"
}
