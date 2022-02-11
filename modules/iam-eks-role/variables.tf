variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "Name of IAM role"
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = null
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = null
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = null
}

variable "role_name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "role_policy_arns" {
  description = "ARNs of any policies to attach to the IAM role"
  type        = list(string)
  default     = []
}

variable "oidc_providers" {
  description = "Map of OIDC providers where each provdier map should contain the `provider`, `provider_arns`, and `service_accounts`"
  type        = any
  default     = {}
}

variable "tags" {
  description = "A map of tags to add the the IAM role"
  type        = map(any)
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

################################################################################
# Policies
################################################################################

# Cluster autoscaler
variable "attach_cluster_autoscaler_policy" {
  description = "Determines whether to attach the Cluster Autoscaler IAM policy to the role"
  type        = bool
  default     = false
}

# External DNS
variable "attach_external_dns_policy" {
  description = "Determines whether to attach the External DNS IAM policy to the role"
  type        = bool
  default     = false
}

variable "external_dns_hosted_zones" {
  description = "Route53 hosted zone IDs to allow external DNS to manage records"
  type        = list(string)
  default     = ["*"]
}

# EBS CSI
variable "attach_ebs_csi_policy" {
  description = "Determines whether to attach the EBS CSI IAM policy to the role"
  type        = bool
  default     = false
}

variable "ebs_csi_kms_cmk_ids" {
  description = "KMS CMK IDs to allow EBS CSI to manage encrypted volumes"
  type        = list(string)
  default     = []
}

# VPC CNI
variable "attach_vpc_cni_policy" {
  description = "Determines whether to attach the VPC CNI IAM policy to the role"
  type        = bool
  default     = false
}

variable "vpc_cni_enable_ipv4" {
  description = "Determines whether to enable IPv4 permissions for VPC CNI policy"
  type        = bool
  default     = false
}

variable "vpc_cni_enable_ipv6" {
  description = "Determines whether to enable IPv6 permissions for VPC CNI policy"
  type        = bool
  default     = false
}
