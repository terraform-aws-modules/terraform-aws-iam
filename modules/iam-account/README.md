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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account_alias | AWS IAM account alias for this account | string | - | yes |
| allow_users_to_change_password | Whether to allow users to change their own password | string | `true` | no |
| create_account_password_policy | Whether to create AWS IAM account password policy | string | `true` | no |
| get_caller_identity | Whether to get AWS account ID, User ID, and ARN in which Terraform is authorized | string | `true` | no |
| hard_expiry | Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset) | string | `false` | no |
| max_password_age | The number of days that an user password is valid. | string | `0` | no |
| minimum_password_length | Minimum length to require for user passwords | string | `8` | no |
| password_reuse_prevention | The number of previous passwords that users are prevented from reusing | string | `true` | no |
| require_lowercase_characters | Whether to require lowercase characters for user passwords | string | `true` | no |
| require_numbers | Whether to require numbers for user passwords | string | `true` | no |
| require_symbols | Whether to require symbols for user passwords | string | `true` | no |
| require_uppercase_characters | Whether to require uppercase characters for user passwords | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| this_caller_identity_account_id | The AWS Account ID number of the account that owns or contains the calling entity |
| this_caller_identity_arn | The AWS ARN associated with the calling entity |
| this_caller_identity_user_id | The unique identifier of the calling entity |
| this_iam_account_password_policy_expire_passwords | Indicates whether passwords in the account expire. Returns true if max_password_age contains a value greater than 0. Returns false if it is 0 or not present. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
