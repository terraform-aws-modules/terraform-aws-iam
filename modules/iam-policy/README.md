# iam-policy

Creates IAM policy.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Whether to create the IAM policy | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy | `string` | `"IAM Policy"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the policy | `string` | `""` | no |
| <a name="input_path"></a> [path](#input\_path) | The path of the policy in IAM | `string` | `"/"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The path of the policy in IAM (tpl file) | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_description"></a> [description](#output\_description) | The description of the policy |
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
| <a name="output_name"></a> [name](#output\_name) | The name of the policy |
| <a name="output_path"></a> [path](#output\_path) | The path of the policy in IAM |
| <a name="output_policy"></a> [policy](#output\_policy) | The policy document |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
