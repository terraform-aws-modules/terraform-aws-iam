# Individual IAM assumable role with SAML Identity Provider example

Configuration in this directory creates a single IAM role which can be assumed by users with a SAML Identity Provider.

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
| terraform | >= 0.12.6 |
| aws | >= 2.23 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.23 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| iam_assumable_role_admin | ../../modules/iam-assumable-role-with-saml |  |

## Resources

| Name |
|------|
| [aws_iam_saml_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_iam\_role\_arn | ARN of IAM role |
| this\_iam\_role\_name | Name of IAM role |
| this\_iam\_role\_path | Path of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
