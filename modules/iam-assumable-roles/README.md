# iam-assumable-roles

Creates predefined IAM roles (admin, poweruser and readonly) which can be assumed by trusted resources.

Trusted resources can be any [IAM ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns) - typically, AWS accounts and users.

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
| [aws_iam_role.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.poweruser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.poweruser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_with_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_role_name"></a> [admin\_role\_name](#input\_admin\_role\_name) | IAM role with admin access | `string` | `"admin"` | no |
| <a name="input_admin_role_path"></a> [admin\_role\_path](#input\_admin\_role\_path) | Path of admin IAM role | `string` | `"/"` | no |
| <a name="input_admin_role_permissions_boundary_arn"></a> [admin\_role\_permissions\_boundary\_arn](#input\_admin\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for admin role | `string` | `""` | no |
| <a name="input_admin_role_policy_arns"></a> [admin\_role\_policy\_arns](#input\_admin\_role\_policy\_arns) | List of policy ARNs to use for admin role | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/AdministratorAccess"<br>]</pre> | no |
| <a name="input_admin_role_requires_mfa"></a> [admin\_role\_requires\_mfa](#input\_admin\_role\_requires\_mfa) | Whether admin role requires MFA | `bool` | `true` | no |
| <a name="input_admin_role_tags"></a> [admin\_role\_tags](#input\_admin\_role\_tags) | A map of tags to add to admin role resource. | `map(string)` | `{}` | no |
| <a name="input_create_admin_role"></a> [create\_admin\_role](#input\_create\_admin\_role) | Whether to create admin role | `bool` | `false` | no |
| <a name="input_create_poweruser_role"></a> [create\_poweruser\_role](#input\_create\_poweruser\_role) | Whether to create poweruser role | `bool` | `false` | no |
| <a name="input_create_readonly_role"></a> [create\_readonly\_role](#input\_create\_readonly\_role) | Whether to create readonly role | `bool` | `false` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `false` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| <a name="input_mfa_age"></a> [mfa\_age](#input\_mfa\_age) | Max age of valid MFA (in seconds) for roles which require MFA | `number` | `86400` | no |
| <a name="input_poweruser_role_name"></a> [poweruser\_role\_name](#input\_poweruser\_role\_name) | IAM role with poweruser access | `string` | `"poweruser"` | no |
| <a name="input_poweruser_role_path"></a> [poweruser\_role\_path](#input\_poweruser\_role\_path) | Path of poweruser IAM role | `string` | `"/"` | no |
| <a name="input_poweruser_role_permissions_boundary_arn"></a> [poweruser\_role\_permissions\_boundary\_arn](#input\_poweruser\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for poweruser role | `string` | `""` | no |
| <a name="input_poweruser_role_policy_arns"></a> [poweruser\_role\_policy\_arns](#input\_poweruser\_role\_policy\_arns) | List of policy ARNs to use for poweruser role | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/PowerUserAccess"<br>]</pre> | no |
| <a name="input_poweruser_role_requires_mfa"></a> [poweruser\_role\_requires\_mfa](#input\_poweruser\_role\_requires\_mfa) | Whether poweruser role requires MFA | `bool` | `true` | no |
| <a name="input_poweruser_role_tags"></a> [poweruser\_role\_tags](#input\_poweruser\_role\_tags) | A map of tags to add to poweruser role resource. | `map(string)` | `{}` | no |
| <a name="input_readonly_role_name"></a> [readonly\_role\_name](#input\_readonly\_role\_name) | IAM role with readonly access | `string` | `"readonly"` | no |
| <a name="input_readonly_role_path"></a> [readonly\_role\_path](#input\_readonly\_role\_path) | Path of readonly IAM role | `string` | `"/"` | no |
| <a name="input_readonly_role_permissions_boundary_arn"></a> [readonly\_role\_permissions\_boundary\_arn](#input\_readonly\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for readonly role | `string` | `""` | no |
| <a name="input_readonly_role_policy_arns"></a> [readonly\_role\_policy\_arns](#input\_readonly\_role\_policy\_arns) | List of policy ARNs to use for readonly role | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/ReadOnlyAccess"<br>]</pre> | no |
| <a name="input_readonly_role_requires_mfa"></a> [readonly\_role\_requires\_mfa](#input\_readonly\_role\_requires\_mfa) | Whether readonly role requires MFA | `bool` | `true` | no |
| <a name="input_readonly_role_tags"></a> [readonly\_role\_tags](#input\_readonly\_role\_tags) | A map of tags to add to readonly role resource. | `map(string)` | `{}` | no |
| <a name="input_trusted_role_arns"></a> [trusted\_role\_arns](#input\_trusted\_role\_arns) | ARNs of AWS entities who can assume these roles | `list(string)` | `[]` | no |
| <a name="input_trusted_role_services"></a> [trusted\_role\_services](#input\_trusted\_role\_services) | AWS Services that can assume these roles | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_iam_role_arn"></a> [admin\_iam\_role\_arn](#output\_admin\_iam\_role\_arn) | ARN of admin IAM role |
| <a name="output_admin_iam_role_name"></a> [admin\_iam\_role\_name](#output\_admin\_iam\_role\_name) | Name of admin IAM role |
| <a name="output_admin_iam_role_path"></a> [admin\_iam\_role\_path](#output\_admin\_iam\_role\_path) | Path of admin IAM role |
| <a name="output_admin_iam_role_requires_mfa"></a> [admin\_iam\_role\_requires\_mfa](#output\_admin\_iam\_role\_requires\_mfa) | Whether admin IAM role requires MFA |
| <a name="output_admin_iam_role_unique_id"></a> [admin\_iam\_role\_unique\_id](#output\_admin\_iam\_role\_unique\_id) | Unique ID of IAM role |
| <a name="output_poweruser_iam_role_arn"></a> [poweruser\_iam\_role\_arn](#output\_poweruser\_iam\_role\_arn) | ARN of poweruser IAM role |
| <a name="output_poweruser_iam_role_name"></a> [poweruser\_iam\_role\_name](#output\_poweruser\_iam\_role\_name) | Name of poweruser IAM role |
| <a name="output_poweruser_iam_role_path"></a> [poweruser\_iam\_role\_path](#output\_poweruser\_iam\_role\_path) | Path of poweruser IAM role |
| <a name="output_poweruser_iam_role_requires_mfa"></a> [poweruser\_iam\_role\_requires\_mfa](#output\_poweruser\_iam\_role\_requires\_mfa) | Whether poweruser IAM role requires MFA |
| <a name="output_poweruser_iam_role_unique_id"></a> [poweruser\_iam\_role\_unique\_id](#output\_poweruser\_iam\_role\_unique\_id) | Unique ID of IAM role |
| <a name="output_readonly_iam_role_arn"></a> [readonly\_iam\_role\_arn](#output\_readonly\_iam\_role\_arn) | ARN of readonly IAM role |
| <a name="output_readonly_iam_role_name"></a> [readonly\_iam\_role\_name](#output\_readonly\_iam\_role\_name) | Name of readonly IAM role |
| <a name="output_readonly_iam_role_path"></a> [readonly\_iam\_role\_path](#output\_readonly\_iam\_role\_path) | Path of readonly IAM role |
| <a name="output_readonly_iam_role_requires_mfa"></a> [readonly\_iam\_role\_requires\_mfa](#output\_readonly\_iam\_role\_requires\_mfa) | Whether readonly IAM role requires MFA |
| <a name="output_readonly_iam_role_unique_id"></a> [readonly\_iam\_role\_unique\_id](#output\_readonly\_iam\_role\_unique\_id) | Unique ID of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
