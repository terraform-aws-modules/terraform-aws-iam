# IAM Bitbucket OIDC Provider

Creates an IAM identity provider for Bitbucket OIDC. See more details here https://support.atlassian.com/bitbucket-cloud/docs/integrate-pipelines-with-resource-servers-using-oidc/

Note: an IAM provider is 1 per account per given URL. This module would be provisioned once per AWS account, and multiple roles created with this provider as the trusted identity (typically 1 role per Bitbucket repository).

## Usage

```hcl
module "iam_bitbucket_oidc_provider" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-bitbucket-oidc-provider"

  tags = {
    Environment = "test"
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id_list"></a> [client\_id\_list](#input\_client\_id\_list) | List of client IDs (also known as audiences) for the IAM OIDC provider. Defaults to STS service if not values are provided | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources created | `map(any)` | `{}` | no |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | The Bitbucket workspace name | `string` | `"YOUR_WORSPACE_NAME"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS for this provider |
| <a name="output_url"></a> [url](#output\_url) | The URL of the identity provider. Corresponds to the iss claim |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->