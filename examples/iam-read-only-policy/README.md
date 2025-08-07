# AWS IAM ReadOnly Policy Example

Configuration in this directory creates a read-only IAM policy and attaches it to an AWS SSO permission set.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_read_only_iam_policy"></a> [read\_only\_iam\_policy](#module\_read\_only\_iam\_policy) | ../../modules/iam-read-only-policy | n/a |
| <a name="module_read_only_iam_policy_disabled"></a> [read\_only\_iam\_policy\_disabled](#module\_read\_only\_iam\_policy\_disabled) | ../../modules/iam-read-only-policy | n/a |
| <a name="module_read_only_iam_policy_doc"></a> [read\_only\_iam\_policy\_doc](#module\_read\_only\_iam\_policy\_doc) | ../../modules/iam-read-only-policy | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
| <a name="output_name"></a> [name](#output\_name) | The name of the policy |
| <a name="output_policy"></a> [policy](#output\_policy) | The policy document |
| <a name="output_policy_json"></a> [policy\_json](#output\_policy\_json) | Policy document JSON |
<!-- END_TF_DOCS -->
