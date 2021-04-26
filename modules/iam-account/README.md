# iam-account

Manage IAM account alias and password policy.

## Notes

* If IAM account alias was previously set (either via AWS console or during the creation of an account from AWS Organizations) you will see this error:
```
* aws_iam_account_alias.this: Error creating account alias with name my-account-alias
```

If you want to manage IAM alias using Terraform (otherwise why are you reading this?) you need to import this resource like this:
```
$ terraform import module.iam_account.aws_iam_account_alias.this this

module.iam_account.aws_iam_account_alias.this: Importing from ID "this"...
module.iam_account.aws_iam_account_alias.this: Import complete!
  Imported aws_iam_account_alias (ID: this)
module.iam_account.aws_iam_account_alias.this: Refreshing state... (ID: this)

Import successful!
``` 

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_account_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_alias) | resource |
| [aws_iam_account_password_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_alias"></a> [account\_alias](#input\_account\_alias) | AWS IAM account alias for this account | `string` | n/a | yes |
| <a name="input_allow_users_to_change_password"></a> [allow\_users\_to\_change\_password](#input\_allow\_users\_to\_change\_password) | Whether to allow users to change their own password | `bool` | `true` | no |
| <a name="input_create_account_password_policy"></a> [create\_account\_password\_policy](#input\_create\_account\_password\_policy) | Whether to create AWS IAM account password policy | `bool` | `true` | no |
| <a name="input_get_caller_identity"></a> [get\_caller\_identity](#input\_get\_caller\_identity) | Whether to get AWS account ID, User ID, and ARN in which Terraform is authorized | `bool` | `true` | no |
| <a name="input_hard_expiry"></a> [hard\_expiry](#input\_hard\_expiry) | Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset) | `bool` | `false` | no |
| <a name="input_max_password_age"></a> [max\_password\_age](#input\_max\_password\_age) | The number of days that an user password is valid. | `number` | `0` | no |
| <a name="input_minimum_password_length"></a> [minimum\_password\_length](#input\_minimum\_password\_length) | Minimum length to require for user passwords | `number` | `8` | no |
| <a name="input_password_reuse_prevention"></a> [password\_reuse\_prevention](#input\_password\_reuse\_prevention) | The number of previous passwords that users are prevented from reusing | `number` | `null` | no |
| <a name="input_require_lowercase_characters"></a> [require\_lowercase\_characters](#input\_require\_lowercase\_characters) | Whether to require lowercase characters for user passwords | `bool` | `true` | no |
| <a name="input_require_numbers"></a> [require\_numbers](#input\_require\_numbers) | Whether to require numbers for user passwords | `bool` | `true` | no |
| <a name="input_require_symbols"></a> [require\_symbols](#input\_require\_symbols) | Whether to require symbols for user passwords | `bool` | `true` | no |
| <a name="input_require_uppercase_characters"></a> [require\_uppercase\_characters](#input\_require\_uppercase\_characters) | Whether to require uppercase characters for user passwords | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_caller_identity_account_id"></a> [caller\_identity\_account\_id](#output\_caller\_identity\_account\_id) | The AWS Account ID number of the account that owns or contains the calling entity |
| <a name="output_caller_identity_arn"></a> [caller\_identity\_arn](#output\_caller\_identity\_arn) | The AWS ARN associated with the calling entity |
| <a name="output_caller_identity_user_id"></a> [caller\_identity\_user\_id](#output\_caller\_identity\_user\_id) | The unique identifier of the calling entity |
| <a name="output_iam_account_password_policy_expire_passwords"></a> [iam\_account\_password\_policy\_expire\_passwords](#output\_iam\_account\_password\_policy\_expire\_passwords) | Indicates whether passwords in the account expire. Returns true if max\_password\_age contains a value greater than 0. Returns false if it is 0 or not present. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
