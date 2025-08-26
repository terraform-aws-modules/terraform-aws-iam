
# AWS IAM Group Terraform Module

Creates an IAM group with IAM policy attached that one or more users can be added to.

## Usage

```hcl
module "iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group"

  name = "superadmins"

  users = [
    "user1",
    "user2"
  ]

  enable_self_management_permissions = true
  permissions = {
    AssumeRole = {
      actions   = ["sts:AssumeRole"]
      resources = ["arn:aws:iam::111111111111:role/admin"]
    }
  }

  policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess",
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Whether to create IAM policy for IAM group | `bool` | `true` | no |
| <a name="input_enable_mfa_enforcement"></a> [enable\_mfa\_enforcement](#input\_enable\_mfa\_enforcement) | Determines whether permissions are added to the policy which requires the groups IAM users to use MFA | `bool` | `true` | no |
| <a name="input_enable_self_management_permissions"></a> [enable\_self\_management\_permissions](#input\_enable\_self\_management\_permissions) | Determines whether permissions are added to the policy which allow the groups IAM users to manage their credentials and MFA | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: `=,.@-_.` | `string` | `""` | no |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the group | `string` | `null` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permissions | <pre>map(object({<br/>    sid           = optional(string)<br/>    actions       = optional(list(string))<br/>    not_actions   = optional(list(string))<br/>    effect        = optional(string, "Allow")<br/>    resources     = optional(list(string))<br/>    not_resources = optional(list(string))<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    condition = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })))<br/>  }))</pre> | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format | `map(string)` | `{}` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | Description of the IAM policy | `string` | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name to use on IAM policy created | `string` | `null` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | The IAM policy path | `string` | `null` | no |
| <a name="input_policy_use_name_prefix"></a> [policy\_use\_name\_prefix](#input\_policy\_use\_name\_prefix) | Determines whether the IAM policy name (`policy_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_users"></a> [users](#input\_users) | A list of IAM User names to associate with the Group | `list(string)` | `[]` | no |
| <a name="input_users_account_id"></a> [users\_account\_id](#input\_users\_account\_id) | An overriding AWS account ID where the group's users reside; leave empty to use the current account ID for the AWS provider | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS for this group |
| <a name="output_id"></a> [id](#output\_id) | The group's ID |
| <a name="output_name"></a> [name](#output\_name) | The group's name |
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | The ARN assigned by AWS for this policy |
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | The policy's ID |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | The policy's name |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID assigned by AWS |
| <a name="output_users"></a> [users](#output\_users) | List of IAM users in IAM group |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/LICENSE).
