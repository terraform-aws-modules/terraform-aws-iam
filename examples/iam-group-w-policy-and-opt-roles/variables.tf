variable "assumable_roles" {
  type        = list(string)
  description = "(possibly empty) List of ARNS for roles assumable by this group"
  default     = []
}
