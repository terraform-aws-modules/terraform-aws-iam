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
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_alias | AWS IAM account alias for this account | `string` | n/a | yes |
| allow\_users\_to\_change\_password | Whether to allow users to change their own password | `bool` | `true` | no |
| create\_account\_password\_policy | Whether to create AWS IAM account password policy | `bool` | `true` | no |
| get\_caller\_identity | Whether to get AWS account ID, User ID, and ARN in which Terraform is authorized | `bool` | `true` | no |
| hard\_expiry | Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset) | `bool` | `false` | no |
| max\_password\_age | The number of days that an user password is valid. | `number` | `0` | no |
| minimum\_password\_length | Minimum length to require for user passwords | `number` | `8` | no |
| password\_reuse\_prevention | The number of previous passwords that users are prevented from reusing | `number` | n/a | yes |
| require\_lowercase\_characters | Whether to require lowercase characters for user passwords | `bool` | `true` | no |
| require\_numbers | Whether to require numbers for user passwords | `bool` | `true` | no |
| require\_symbols | Whether to require symbols for user passwords | `bool` | `true` | no |
| require\_uppercase\_characters | Whether to require uppercase characters for user passwords | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_caller\_identity\_account\_id | The AWS Account ID number of the account that owns or contains the calling entity |
| this\_caller\_identity\_arn | The AWS ARN associated with the calling entity |
| this\_caller\_identity\_user\_id | The unique identifier of the calling entity |
| this\_iam\_account\_password\_policy\_expire\_passwords | Indicates whether passwords in the account expire. Returns true if max\_password\_age contains a value greater than 0. Returns false if it is 0 or not present. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
