# IAM group with policies example

Configuration in this directory creates IAM group with users who has specified IAM policies.

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
| iam\_account\_id | IAM AWS account id |
| this\_group\_name | IAM group name |
| this\_group\_users | List of IAM users in IAM group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
