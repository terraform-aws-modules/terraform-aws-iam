# Individual IAM assumable roles example

Configuration in this directory creates several individual IAM roles which can be assumed from a defined list of [IAM ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).

The main difference between `iam-assumable-role` and `iam-assumable-roles` examples is that the former creates just a single role.

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
| <a name="module_iam_assumable_role_admin"></a> [iam\_assumable\_role\_admin](#module\_iam\_assumable\_role\_admin) | ../../modules/iam-assumable-role | n/a |
| <a name="module_iam_assumable_role_custom"></a> [iam\_assumable\_role\_custom](#module\_iam\_assumable\_role\_custom) | ../../modules/iam-assumable-role | n/a |
| <a name="module_iam_assumable_role_custom_trust_policy"></a> [iam\_assumable\_role\_custom\_trust\_policy](#module\_iam\_assumable\_role\_custom\_trust\_policy) | ../../modules/iam-assumable-role | n/a |
| <a name="module_iam_assumable_role_sts"></a> [iam\_assumable\_role\_sts](#module\_iam\_assumable\_role\_sts) | ../../modules/iam-assumable-role | n/a |
| <a name="module_iam_policy"></a> [iam\_policy](#module\_iam\_policy) | ../../modules/iam-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.custom_trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_instance_profile_id"></a> [iam\_instance\_profile\_id](#output\_iam\_instance\_profile\_id) | IAM Instance profile's ID. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
| <a name="output_role_requires_mfa"></a> [role\_requires\_mfa](#output\_role\_requires\_mfa) | Whether admin IAM role requires MFA |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
