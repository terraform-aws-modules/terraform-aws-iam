# iam-eks-role

Creates single IAM role which can be assumed by one or more EKS `ServiceAccount` and optionally also OpenID Connect Federated Users.

This module is for use with AWS EKS. For details of how a `ServiceAccount` in EKS can assume an IAM role, see the [EKS documentation](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).

This module supports multiple `ServiceAccount` in multiple clusters and/or namespaces. This allows for a single IAM role to be used when an application may span multiple clusters (e.g. for DR) or multiple namespaces (e.g. for canary deployments). The variables `cluster_service_accounts` and `provider_url_sa_pairs` are used for this as follows:

```hcl
module "iam_eks_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-eks-role"

  cluster_service_accounts = {
    "<EKS cluster name>" = [
      "<namespace>:<ServiceAccount name>",
      "<namespace>:<another ServiceAccount name>"
    ]
  }

  provider_url_sa_pairs = {
    "<OIDC provider without protocol prefix>" = [
      "<namespace>:<ServiceAccount name>",
      "<namespace>:<another ServiceAccount name>"
    ]
  }
}
```

For example, to create an IAM role named `my-app` that can be assumed from the `ServiceAccount` named `my-app-staging` in the namespace `default` and `canary` in EKS cluster named `cluster-main-1`; and also the `ServiceAccount` name `my-app-staging` in the namespace `default` in EKS cluster named `cluster-backup-1`, the configuration would be:

```hcl
module "iam_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-eks-role"
  role_name = "my-app"

  cluster_service_accounts = {
    "cluster-main-1" = [
      "default:my-app-staging",
      "canary:my-app-staging"
    ],
    "cluster-backup-1" = [
      "default:my-app-staging",
    ]
  }
}
```

Note: the EKS clusters must in the current AWS region and account as they use the default AWS provider.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.23 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_with_oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_cluster_autoscaler_policy"></a> [attach\_cluster\_autoscaler\_policy](#input\_attach\_cluster\_autoscaler\_policy) | Determines whether to attach the Cluster Autoscaler IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_ebs_csi_policy"></a> [attach\_ebs\_csi\_policy](#input\_attach\_ebs\_csi\_policy) | Determines whether to attach the EBS CSI IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_external_dns_policy"></a> [attach\_external\_dns\_policy](#input\_attach\_external\_dns\_policy) | Determines whether to attach the External DNS IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_vpc_cni_policy"></a> [attach\_vpc\_cni\_policy](#input\_attach\_vpc\_cni\_policy) | Determines whether to attach the VPC CNI IAM policy to the role | `bool` | `false` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create a role | `bool` | `true` | no |
| <a name="input_ebs_csi_kms_cmk_ids"></a> [ebs\_csi\_kms\_cmk\_ids](#input\_ebs\_csi\_kms\_cmk\_ids) | KMS CMK IDs to allow EBS CSI to manage encrypted volumes | `list(string)` | `[]` | no |
| <a name="input_external_dns_hosted_zones"></a> [external\_dns\_hosted\_zones](#input\_external\_dns\_hosted\_zones) | Route53 hosted zone IDs to allow external DNS to manage records | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `true` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_oidc_providers"></a> [oidc\_providers](#input\_oidc\_providers) | Map of OIDC providers where each provdier map should contain the `provider`, `provider_arns`, and `service_accounts` | `any` | `{}` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_role_name_prefix"></a> [role\_name\_prefix](#input\_role\_name\_prefix) | IAM role name prefix | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `null` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add the the IAM role | `map(any)` | `{}` | no |
| <a name="input_vpc_cni_enable_ipv4"></a> [vpc\_cni\_enable\_ipv4](#input\_vpc\_cni\_enable\_ipv4) | Determines whether to enable IPv4 permissions for VPC CNI policy | `bool` | `false` | no |
| <a name="input_vpc_cni_enable_ipv6"></a> [vpc\_cni\_enable\_ipv6](#input\_vpc\_cni\_enable\_ipv6) | Determines whether to enable IPv6 permissions for VPC CNI policy | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
