# IAM CircelCI OIDC Provider

Creates an IAM identity provider for CircelCI OIDC. See more details here https://circleci.com/blog/openid-connect-identity-tokens/

Note: an IAM provider is 1 per account per given URL. This module would be provisioned once per AWS account, and multiple roles created with this provider as the trusted identity (typically 1 role per GitHub repository).

## Usage

```hcl
module "iam_circleci_oidc_provider" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-circleci-oidc-provider"

  org_uuid = "<UUID-of-CircleCI-org>"

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

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_url"></a> [base\_url](#input\_base\_url) | The URL of the identity provider. Corresponds to the iss claim | `string` | `"https://oidc.circleci.com/org"` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_org_uuid"></a> [org\_uuid](#input\_org\_uuid) | The CircleCI organization UUID that will be authorized to assume the role. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources created | `map(any)` | `{}` | no |
| <a name="input_thumbprints"></a> [thumbprints](#input\_thumbprints) | List of thumbprints of CircleCI | `list(string)` | <pre>[<br>  "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS for this provider |
| <a name="output_url"></a> [url](#output\_url) | The URL of the identity provider. Corresponds to the iss claim |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
