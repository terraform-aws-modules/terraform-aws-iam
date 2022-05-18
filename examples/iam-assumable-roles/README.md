# IAM assumable roles example

Configuration in this directory creates several IAM roles which can be assumed from a defined list of [IAM ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_assumable_roles"></a> [iam\_assumable\_roles](#module\_iam\_assumable\_roles) | ../../modules/iam-assumable-roles | n/a |

## Resources

No resources.

## Inputs

No inputs.

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
