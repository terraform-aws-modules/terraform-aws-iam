# IAM assumable roles with SAML Identity Provider example

Configuration in this directory creates several IAM roles which can be assumed by users with a SAML Identity Provider.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.23 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_assumable_roles_with_saml"></a> [iam\_assumable\_roles\_with\_saml](#module\_iam\_assumable\_roles\_with\_saml) | ../../modules/iam-assumable-roles-with-saml | n/a |
| <a name="module_iam_assumable_roles_with_saml_custom"></a> [iam\_assumable\_roles\_with\_saml\_custom](#module\_iam\_assumable\_roles\_with\_saml\_custom) | ../../modules/iam-assumable-roles-with-saml | n/a |
| <a name="module_iam_assumable_roles_with_saml_second_provider"></a> [iam\_assumable\_roles\_with\_saml\_second\_provider](#module\_iam\_assumable\_roles\_with\_saml\_second\_provider) | ../../modules/iam-assumable-roles-with-saml | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_saml_provider.idp_saml](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |
| [aws_iam_saml_provider.second_idp_saml](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_iam_role_arn"></a> [admin\_iam\_role\_arn](#output\_admin\_iam\_role\_arn) | ARN of admin IAM role |
| <a name="output_admin_iam_role_name"></a> [admin\_iam\_role\_name](#output\_admin\_iam\_role\_name) | Name of admin IAM role |
| <a name="output_admin_iam_role_path"></a> [admin\_iam\_role\_path](#output\_admin\_iam\_role\_path) | Path of admin IAM role |
| <a name="output_admin_iam_role_unique_id"></a> [admin\_iam\_role\_unique\_id](#output\_admin\_iam\_role\_unique\_id) | Unique ID of IAM role |
| <a name="output_poweruser_iam_role_arn"></a> [poweruser\_iam\_role\_arn](#output\_poweruser\_iam\_role\_arn) | ARN of poweruser IAM role |
| <a name="output_poweruser_iam_role_name"></a> [poweruser\_iam\_role\_name](#output\_poweruser\_iam\_role\_name) | Name of poweruser IAM role |
| <a name="output_poweruser_iam_role_path"></a> [poweruser\_iam\_role\_path](#output\_poweruser\_iam\_role\_path) | Path of poweruser IAM role |
| <a name="output_poweruser_iam_role_unique_id"></a> [poweruser\_iam\_role\_unique\_id](#output\_poweruser\_iam\_role\_unique\_id) | Unique ID of IAM role |
| <a name="output_readonly_iam_role_arn"></a> [readonly\_iam\_role\_arn](#output\_readonly\_iam\_role\_arn) | ARN of readonly IAM role |
| <a name="output_readonly_iam_role_name"></a> [readonly\_iam\_role\_name](#output\_readonly\_iam\_role\_name) | Name of readonly IAM role |
| <a name="output_readonly_iam_role_path"></a> [readonly\_iam\_role\_path](#output\_readonly\_iam\_role\_path) | Path of readonly IAM role |
| <a name="output_readonly_iam_role_unique_id"></a> [readonly\_iam\_role\_unique\_id](#output\_readonly\_iam\_role\_unique\_id) | Unique ID of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
