# IAM user example

Configuration in this directory creates IAM policies.

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
| <a name="module_iam_policy"></a> [iam\_policy](#module\_iam\_policy) | ../../modules/iam-policy | n/a |
| <a name="module_iam_policy_from_data_source"></a> [iam\_policy\_from\_data\_source](#module\_iam\_policy\_from\_data\_source) | ../../modules/iam-policy | n/a |
| <a name="module_iam_policy_optional"></a> [iam\_policy\_optional](#module\_iam\_policy\_optional) | ../../modules/iam-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

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
