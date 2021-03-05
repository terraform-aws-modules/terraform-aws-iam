variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = false
}

variable "provider_id" {
  description = "ID of the SAML Provider. Use provider_ids to specify several IDs."
  type        = string
  default     = ""
}

variable "provider_ids" {
  description = "List of SAML Provider IDs"
  type        = list(string)
  default     = []
}

variable "aws_saml_endpoint" {
  description = "AWS SAML Endpoint"
  default     = "https://signin.aws.amazon.com/saml"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
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

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = ""
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "number_of_role_policy_arns" {
  description = "Number of IAM policies to attach to IAM role"
  type        = number
  default     = null
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}
