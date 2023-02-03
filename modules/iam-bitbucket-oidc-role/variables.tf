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
# Bitbucket OIDC Role
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
  description = "Audience to use for OIDC role. Defaults to `sts.amazonaws.com`"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "subjects" {
  description = "List of Bitbucket OIDC subjects that are permitted by the trust policy. Example: `['{REPO_UUID}:*', '{REPOSITORY_UUID}:{ENVIRONMENT_UUID}:{STEP_UUID}']`"
  type        = list(string)
  default     = []
}

variable "workspace" {
  description = "The Bitbucket workspace name"
  type        = string
  default     = "YOUR_WORSPACE_NAME"
}
