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
  description = "Map of OIDC providers where each provdier map should contain the `provider`, `provider_arns`, and `namespace_service_accounts`"
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

variable "assume_role_condition_test" {
  description = "Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role"
  type        = string
  default     = "StringEquals"
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

variable "cluster_autoscaler_cluster_ids" {
  description = "List of cluster IDs to appropriately scope permissions within the Cluster Autoscaler IAM policy"
  type        = list(string)
  default     = []
}

# External DNS
variable "attach_external_dns_policy" {
  description = "Determines whether to attach the External DNS IAM policy to the role"
  type        = bool
  default     = false
}

variable "external_dns_hosted_zone_arns" {
  description = "Route53 hosted zone ARNs to allow external DNS to manage records"
  type        = list(string)
  default     = ["arn:aws:route53:::hostedzone/*"]
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

# EFS CSI
variable "attach_efs_csi_policy" {
  description = "Determines whether to attach the EFS CSI IAM policy to the role"
  type        = bool
  default     = false
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

# Node termination handler
variable "attach_node_termination_handler_policy" {
  description = "Determines whether to attach the Node Termination Handler policy to the role"
  type        = bool
  default     = false
}

variable "node_termination_handler_sqs_queue_arns" {
  description = "List of SQS ARNs that contain node termination events"
  type        = list(string)
  default     = ["*"]
}

# Karpetner controller
variable "attach_karpenter_controller_policy" {
  description = "Determines whether to attach the Karpenter Controller policy to the role"
  type        = bool
  default     = false
}

variable "karpenter_controller_cluster_id" {
  description = "Cluster ID where the Karpenter controller is provisioned/managing"
  type        = string
  default     = "*"
}

variable "karpenter_tag_key" {
  description = "Tag key (`{key = value}`) applied to resources launched by Karpenter through the Karpenter provisioner"
  type        = string
  default     = "karpenter.sh/discovery"
}

variable "karpenter_controller_ssm_parameter_arns" {
  description = "List of SSM Parameter ARNs that contain AMI IDs launched by Karpenter"
  type        = list(string)
  # https://github.com/aws/karpenter/blob/ed9473a9863ca949b61b9846c8b9f33f35b86dbd/pkg/cloudprovider/aws/ami.go#L105-L123
  default = ["arn:aws:ssm:*:*:parameter/aws/service/*"]
}

variable "karpenter_controller_node_iam_role_arns" {
  description = "List of node IAM role ARNs Karpenter can use to launch nodes"
  type        = list(string)
  default     = ["*"]
}

# AWS Load Balancer Controller
variable "attach_load_balancer_controller_policy" {
  description = "Determines whether to attach the Load Balancer Controller policy to the role"
  type        = bool
  default     = false
}

# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/targetgroupbinding/targetgroupbinding/#reference
# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/deploy/installation/#setup-iam-manually
variable "attach_load_balancer_controller_targetgroup_binding_only_policy" {
  description = "Determines whether to attach the Load Balancer Controller policy for the TargetGroupBinding only"
  type        = bool
  default     = false
}

# Amazon Managed Service for Prometheus
variable "attach_amazon_managed_service_prometheus_policy" {
  description = "Determines whether to attach the Amazon Managed Service for Prometheus IAM policy to the role"
  type        = bool
  default     = false
}

variable "amazon_managed_service_prometheus_workspace_arns" {
  description = "List of AMP Workspace ARNs to read and write metrics"
  type        = list(string)
  default     = ["*"]
}
