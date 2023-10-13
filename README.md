# IAM GitHub OIDC Role

Creates an IAM role that trust the IAM Google OIDC built in provider.
- AWS IAM role reference: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create

## Usage

### Google

The defaults provided by the module are suitable for testing with any Google service account.

```hcl
module "iam_google_oidc_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-google-oidc-role"

  # This should be updated to suit your organization, repository, references/branches, etc.
  google_service_account_ids = ["123456789101112131415"]
  google_service_account_emails = ["aws-role-access@project-acme.iam.gserviceaccount.com"]

  policies = {
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  tags = {
    Environment = "test"
  }
}
```

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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audience"></a> [audience](#input\_audience) | Audience to use for OIDC role. Defaults to `sts.amazonaws.com` for use with the [official AWS GitHub action](https://github.com/aws-actions/configure-aws-credentials) | `string` | `"sts.amazonaws.com"` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `true` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | IAM role name prefix | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format | `map(string)` | `{}` | no |
| <a name="input_provider_url"></a> [provider\_url](#input\_provider\_url) | The URL of the identity provider. Corresponds to the iss claim | `string` | `"token.actions.githubusercontent.com"` | no |
| <a name="input_subjects"></a> [subjects](#input\_subjects) | List of GitHub OIDC subjects that are permitted by the trust policy. You do not need to prefix with `repo:` as this is provided. Example: `['my-org/my-repo:*', 'octo-org/octo-repo:ref:refs/heads/octo-branch']` | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources created | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of IAM role |
| <a name="output_name"></a> [name](#output\_name) | Name of IAM role |
| <a name="output_path"></a> [path](#output\_path) | Path of IAM role |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | Unique ID of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
# IAM Google OIDC Role

Creates an IAM role that trust the IAM Google OIDC built in provider.
- AWS IAM role reference: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create

## Usage

### Google

The defaults provided by the module are suitable for testing with any Google service account.

```hcl
module "iam_google_oidc_role" {
source    = "terraform-aws-modules/iam/aws//modules/iam-google-oidc-role"

# This should be updated to suit your organization, repository, references/branches, etc.
google_service_account_ids = ["123456789101112131415"]
google_service_account_emails = ["aws-role-access@project-acme.iam.gserviceaccount.com"]

policies = {
S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

tags = {
Environment = "test"
}
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `true` | no |
| <a name="input_google_service_account_emails"></a> [google\_service\_account\_emails](#input\_google\_service\_account\_emails) | Must be the google service account email address. | `list(string)` | `[]` | no |
| <a name="input_google_service_account_ids"></a> [google\_service\_account\_ids](#input\_google\_service\_account\_ids) | Must be the google service account IDs (not email address). This is used for both subjects | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | IAM role name prefix | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format | `map(string)` | `{}` | no |
| <a name="input_provider_url"></a> [provider\_url](#input\_provider\_url) | The URL of the identity provider. Corresponds to the iss claim | `string` | `"accounts.google.com"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources created | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of IAM role |
| <a name="output_name"></a> [name](#output\_name) | Name of IAM role |
| <a name="output_path"></a> [path](#output\_path) | Path of IAM role |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | Unique ID of IAM role |
<!-- END_TF_DOCS -->