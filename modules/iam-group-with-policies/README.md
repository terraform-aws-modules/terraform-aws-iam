# iam-group-with-policies

Creates IAM group with specified IAM policies, and add users into a group.

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
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.custom_arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.iam_self_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.iam_self_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.iam_self_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_iam_self_management_policy"></a> [attach\_iam\_self\_management\_policy](#input\_attach\_iam\_self\_management\_policy) | Whether to attach IAM policy which allows IAM users to manage their credentials and MFA | `bool` | `true` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS account id to use inside IAM policies. If empty, current AWS account ID will be used. | `string` | `""` | no |
| <a name="input_create_group"></a> [create\_group](#input\_create\_group) | Whether to create IAM group | `bool` | `true` | no |
| <a name="input_custom_group_policies"></a> [custom\_group\_policies](#input\_custom\_group\_policies) | List of maps of inline IAM policies to attach to IAM group. Should have `name` and `policy` keys in each element. | `list(map(string))` | `[]` | no |
| <a name="input_custom_group_policy_arns"></a> [custom\_group\_policy\_arns](#input\_custom\_group\_policy\_arns) | List of IAM policies ARNs to attach to IAM group | `list(string)` | `[]` | no |
| <a name="input_group_users"></a> [group\_users](#input\_group\_users) | List of IAM users to have in an IAM group which can assume the role | `list(string)` | `[]` | no |
| <a name="input_iam_self_management_policy_name_prefix"></a> [iam\_self\_management\_policy\_name\_prefix](#input\_iam\_self\_management\_policy\_name\_prefix) | Name prefix for IAM policy to create with IAM self-management permissions | `string` | `"IAMSelfManagement-"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of IAM group | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_account_id"></a> [aws\_account\_id](#output\_aws\_account\_id) | IAM AWS account id |
| <a name="output_group_arn"></a> [group\_arn](#output\_group\_arn) | IAM group arn |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | IAM group name |
| <a name="output_group_users"></a> [group\_users](#output\_group\_users) | List of IAM users in IAM group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
