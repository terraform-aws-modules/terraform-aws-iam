variable "name" {
  description = "Name of IAM policy and IAM group"
  type        = string
}

variable "path" {
  description = "Path of IAM policy and IAM group"
  type        = string
  default     = "/"
}

variable "assumable_roles" {
  description = "List of IAM roles ARNs which can be assumed by the group"
  type        = list(string)
  default     = []
}

variable "assumable_roles_policy_name_suffix" {
  description = "Append this name to the policy name that will be created for assuming the given roles (default: null -- the policy name will be group name)"
  type        = string
  default     = ""
}

variable "group_users" {
  description = "List of IAM users to have in an IAM group which can assume the role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
