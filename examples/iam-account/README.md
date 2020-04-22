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

No requirements.

## Providers

No provider.

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_caller\_identity\_account\_id | The ID of the AWS account |
| this\_iam\_account\_password\_policy\_expire\_passwords | Indicates whether passwords in the account expire. Returns true if max\_password\_age contains a value greater than 0. Returns false if it is 0 or not present. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
