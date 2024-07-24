variable "create" {
  description = "Controls if resources should be created (affects all resources)"
  type        = bool
  default     = true
  nullable    = false
}

variable "tags" {
  description = "A map of tags to add to the resources created"
  type        = map(any)
  default     = {}
  nullable    = false
}

variable "org_uuid" {
  description = "The CircleCI organization UUID that will be authorized to assume the role."
  type        = string
  nullable    = false
}

variable "base_url" {
  description = "The URL of the identity provider. Corresponds to the iss claim"
  type        = string
  default     = "https://oidc.circleci.com/org"
  nullable    = false
}

variable "thumbprints" {
  description = "List of thumbprints of CircleCI"
  type        = list(string)
  default     = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  nullable    = false
}
