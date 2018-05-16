# IAM account example

Configuration in this directory sets [AWS account alias](https://docs.aws.amazon.com/IAM/latest/UserGuide/console_account-alias.html) (also known as Console Account alias) and configures password policy.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Outputs

| Name | Description |
|------|-------------|
| this_caller_identity_account_id | The ID of the AWS account |
| this_iam_account_password_policy_expire_passwords | Indicates whether passwords in the account expire. Returns true if max_password_age contains a value greater than 0. Returns false if it is 0 or not present. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
