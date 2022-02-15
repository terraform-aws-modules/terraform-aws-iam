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
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.assume_role_with_oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_service_accounts"></a> [cluster\_service\_accounts](#input\_cluster\_service\_accounts) | EKS cluster and k8s ServiceAccount pairs. Each EKS cluster can have multiple k8s ServiceAccount. See README for details | `map(list(string))` | `{}` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create a role | `bool` | `true` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `false` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `43200` | no |
| <a name="input_provider_url_sa_pairs"></a> [provider\_url\_sa\_pairs](#input\_provider\_url\_sa\_pairs) | OIDC provider URL and k8s ServiceAccount pairs. If the assume role policy requires a mix of EKS clusters and other OIDC providers then this can be used | `map(list(string))` | `{}` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_role_name_prefix"></a> [role\_name\_prefix](#input\_role\_name\_prefix) | IAM role name prefix | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `""` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add the the IAM role | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
