# IAM read-only policy example

Configuration in this directory creates read-only IAM policy and attaches it to AWS SSO.

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
| <a name="module_read_only_iam_policy"></a> [read\_only\_iam\_policy](#module\_read\_only\_iam\_policy) | ../../modules/iam-read-only-policy | n/a |
| <a name="module_read_only_iam_policy_doc"></a> [read\_only\_iam\_policy\_doc](#module\_read\_only\_iam\_policy\_doc) | ../../modules/iam-read-only-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ssoadmin_permission_set.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set) | resource |
| [aws_ssoadmin_permission_set_inline_policy.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set_inline_policy) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_description"></a> [description](#output\_description) | The description of the policy |
| <a name="output_id"></a> [id](#output\_id) | The policy ID |
| <a name="output_name"></a> [name](#output\_name) | The name of the policy |
| <a name="output_path"></a> [path](#output\_path) | The path of the policy in IAM |
| <a name="output_policy"></a> [policy](#output\_policy) | The policy document |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
