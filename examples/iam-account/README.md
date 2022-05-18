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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_account"></a> [iam\_account](#module\_iam\_account) | ../../modules/iam-account | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_caller_identity_account_id"></a> [caller\_identity\_account\_id](#output\_caller\_identity\_account\_id) | The ID of the AWS account |
| <a name="output_iam_account_password_policy_expire_passwords"></a> [iam\_account\_password\_policy\_expire\_passwords](#output\_iam\_account\_password\_policy\_expire\_passwords) | Indicates whether passwords in the account expire. Returns true if max\_password\_age contains a value greater than 0. Returns false if it is 0 or not present. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
