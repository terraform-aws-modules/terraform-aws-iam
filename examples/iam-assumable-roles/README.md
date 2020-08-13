# IAM assumable roles example

Configuration in this directory creates several IAM roles which can be assumed from a defined list of [IAM ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).

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
| admin\_iam\_role\_arn | ARN of admin IAM role |
| admin\_iam\_role\_name | Name of admin IAM role |
| admin\_iam\_role\_path | Path of admin IAM role |
| admin\_iam\_role\_requires\_mfa | Whether admin IAM role requires MFA |
| poweruser\_iam\_role\_arn | ARN of poweruser IAM role |
| poweruser\_iam\_role\_name | Name of poweruser IAM role |
| poweruser\_iam\_role\_path | Path of poweruser IAM role |
| poweruser\_iam\_role\_requires\_mfa | Whether poweruser IAM role requires MFA |
| readonly\_iam\_role\_arn | ARN of readonly IAM role |
| readonly\_iam\_role\_name | Name of readonly IAM role |
| readonly\_iam\_role\_path | Path of readonly IAM role |
| readonly\_iam\_role\_requires\_mfa | Whether readonly IAM role requires MFA |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
