variable "name" {
  description = "Name of IAM policy and IAM group"
  type        = string
}

variable "path" {
  description = "Path of IAM policy and IAM group"
  type        = string
  default     = "/"
  validation {
    condition = alltrue([
      startswith(var.path, "/"),
      endswith(var.path, "/"),
    ])
    error_message = "IAM path must include leading and trailing slashes"
  }
}

variable "assumable_roles" {
  description = "List of IAM roles ARNs which can be assumed by the group"
  type        = list(string)
  default     = []
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
