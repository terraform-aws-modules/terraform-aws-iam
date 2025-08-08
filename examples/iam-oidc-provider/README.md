# AWS IAM OIDC Provider Example

- Creates an IAM identity provider for GitHub OIDC
- Creates an IAM role that trust the IAM GitHub OIDC provider
  - GitHub reference: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
  - AWS IAM role reference: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create_GitHub

Note: an IAM provider is 1 per account per given URL. This module would be provisioned once per AWS account, and multiple roles created with this provider as the trusted identity (typically 1 role per GitHub repository).

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
| <a name="module_github_oidc_iam_provider"></a> [github\_oidc\_iam\_provider](#module\_github\_oidc\_iam\_provider) | ../../modules/iam-oidc-provider | n/a |
| <a name="module_github_oidc_iam_role"></a> [github\_oidc\_iam\_role](#module\_github\_oidc\_iam\_role) | ../../modules/iam-role | n/a |
| <a name="module_oidc_iam_provider_disabled"></a> [oidc\_iam\_provider\_disabled](#module\_oidc\_iam\_provider\_disabled) | ../../modules/iam-oidc-provider | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_oidc_iam_provider_arn"></a> [github\_oidc\_iam\_provider\_arn](#output\_github\_oidc\_iam\_provider\_arn) | The ARN assigned by AWS for this provider |
| <a name="output_github_oidc_iam_provider_url"></a> [github\_oidc\_iam\_provider\_url](#output\_github\_oidc\_iam\_provider\_url) | The URL of the identity provider. Corresponds to the iss claim |
| <a name="output_github_oidc_iam_role_arn"></a> [github\_oidc\_iam\_role\_arn](#output\_github\_oidc\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_github_oidc_iam_role_name"></a> [github\_oidc\_iam\_role\_name](#output\_github\_oidc\_iam\_role\_name) | Name of IAM role |
| <a name="output_github_oidc_iam_role_unique_id"></a> [github\_oidc\_iam\_role\_unique\_id](#output\_github\_oidc\_iam\_role\_unique\_id) | Unique ID of IAM role |
<!-- END_TF_DOCS -->
