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
# OIDC Provider
################################################################################

variable "client_id_list" {
  description = "List of client IDs (also known as audiences) for the IAM OIDC provider. Defaults to STS service if no values are provided"
  type        = list(string)
  default     = []
}

variable "url" {
  description = "The URL of the identity provider. Corresponds to the iss claim"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}
