# AWS IAM Account Terraform Module

Creates an account policy and account alias. Module instantiation is once per account.

## Usage

```hcl
module "iam_account" {
  source = "terraform-aws-modules/iam/aws//modules/iam-account"

  account_alias = "awesome-company"

  max_password_age               = 90
  minimum_password_length        = 24
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  password_reuse_prevention      = 3
  allow_users_to_change_password = true
}
```

## Notes

If IAM account alias was previously set (either via AWS console or during the creation of an account from AWS Organizations) you will see this error:

```sh
aws_iam_account_alias.this: Error creating account alias with name my-account-alias
```

If you want to manage IAM alias using Terraform (otherwise why are you reading this?) you need to import this resource like this:

```sh
$ terraform import "module.iam_account.aws_iam_account_alias.this[0]" this

module.iam_account.aws_iam_account_alias.this: Importing from ID "this"...
module.iam_account.aws_iam_account_alias.this: Import complete!
  Imported aws_iam_account_alias (ID: this)
module.iam_account.aws_iam_account_alias.this: Refreshing state... (ID: this)

Import successful!
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_account_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_alias) | resource |
| [aws_iam_account_password_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_alias"></a> [account\_alias](#input\_account\_alias) | AWS IAM account alias for this account | `string` | n/a | yes |
| <a name="input_allow_users_to_change_password"></a> [allow\_users\_to\_change\_password](#input\_allow\_users\_to\_change\_password) | Whether to allow users to change their own password | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_account_password_policy"></a> [create\_account\_password\_policy](#input\_create\_account\_password\_policy) | Whether to create AWS IAM account password policy | `bool` | `true` | no |
| <a name="input_hard_expiry"></a> [hard\_expiry](#input\_hard\_expiry) | Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset) | `bool` | `false` | no |
| <a name="input_max_password_age"></a> [max\_password\_age](#input\_max\_password\_age) | The number of days that an user password is valid | `number` | `0` | no |
| <a name="input_minimum_password_length"></a> [minimum\_password\_length](#input\_minimum\_password\_length) | Minimum length to require for user passwords | `number` | `8` | no |
| <a name="input_password_reuse_prevention"></a> [password\_reuse\_prevention](#input\_password\_reuse\_prevention) | The number of previous passwords that users are prevented from reusing | `number` | `null` | no |
| <a name="input_require_lowercase_characters"></a> [require\_lowercase\_characters](#input\_require\_lowercase\_characters) | Whether to require lowercase characters for user passwords | `bool` | `true` | no |
| <a name="input_require_numbers"></a> [require\_numbers](#input\_require\_numbers) | Whether to require numbers for user passwords | `bool` | `true` | no |
| <a name="input_require_symbols"></a> [require\_symbols](#input\_require\_symbols) | Whether to require symbols for user passwords | `bool` | `true` | no |
| <a name="input_require_uppercase_characters"></a> [require\_uppercase\_characters](#input\_require\_uppercase\_characters) | Whether to require uppercase characters for user passwords | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_account_password_policy_expire_passwords"></a> [iam\_account\_password\_policy\_expire\_passwords](#output\_iam\_account\_password\_policy\_expire\_passwords) | Indicates whether passwords in the account expire. Returns true if max\_password\_age contains a value greater than 0. Returns false if it is 0 or not present |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/LICENSE).
