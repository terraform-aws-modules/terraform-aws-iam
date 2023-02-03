# IAM GitHub OIDC

- Creates an IAM identity provider for Bitbucket OIDC
- Creates an IAM role that trust the IAM Bitbucket OIDC provider
  - Bitbucket reference: https://support.atlassian.com/bitbucket-cloud/docs/integrate-pipelines-with-resource-servers-using-oidc/
  - AWS IAM role reference: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html

Note: an IAM provider is 1 per account per given URL. This module would be provisioned once per AWS account, and multiple roles created with this provider as the trusted identity (typically 1 role per Bitbucket workspace).

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

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_bitbucket_oidc_provider"></a> [iam\_bitbucket\_oidc\_provider](#module\_iam\_bitbucket\_oidc\_provider) | ../../modules/iam-bitbucket-oidc-provider | n/a |
| <a name="module_iam_bitbucket_oidc_provider_disabled"></a> [iam\_bitbucket\_oidc\_provider\_disabled](#module\_iam\_bitbucket\_oidc\_provider\_disabled) | ../../modules/iam-bitbucket-oidc-provider | n/a |
| <a name="module_iam_bitbucket_oidc_role"></a> [iam\_bitbucket\_oidc\_role](#module\_iam\_bitbucket\_oidc\_role) | ../../modules/iam-bitbucket-oidc-role | n/a |
| <a name="module_iam_bitbucket_oidc_role_disabled"></a> [iam\_bitbucket\_oidc\_role\_disabled](#module\_iam\_bitbucket\_oidc\_role\_disabled) | ../../modules/iam-bitbucket-oidc-role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
| <a name="output_provider_arn"></a> [provider\_arn](#output\_provider\_arn) | The ARN assigned by AWS for this provider |
| <a name="output_provider_url"></a> [provider\_url](#output\_provider\_url) | The URL of the identity provider. Corresponds to the iss claim |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
