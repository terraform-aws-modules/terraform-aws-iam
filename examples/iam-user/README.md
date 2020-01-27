# IAM user example

Configuration in this directory creates IAM user with a random password, a pair of IAM access/secret keys and uploads IAM SSH public key.
User password and secret key is encrypted using public key of keybase.io user named `test`.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| keybase\_password\_decrypt\_command | n/a |
| keybase\_password\_pgp\_message | n/a |
| keybase\_secret\_key\_decrypt\_command | n/a |
| keybase\_secret\_key\_pgp\_message | n/a |
| pgp\_key | PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted) |
| this\_iam\_access\_key\_encrypted\_secret | The encrypted secret, base64 encoded |
| this\_iam\_access\_key\_id | The access key ID |
| this\_iam\_access\_key\_key\_fingerprint | The fingerprint of the PGP key used to encrypt the secret |
| this\_iam\_access\_key\_secret | The access key secret |
| this\_iam\_access\_key\_ses\_smtp\_password | The secret access key converted into an SES SMTP password |
| this\_iam\_access\_key\_status | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| this\_iam\_user\_arn | The ARN assigned by AWS for this user |
| this\_iam\_user\_login\_profile\_encrypted\_password | The encrypted password, base64 encoded |
| this\_iam\_user\_login\_profile\_key\_fingerprint | The fingerprint of the PGP key used to encrypt the password |
| this\_iam\_user\_name | The user's name |
| this\_iam\_user\_unique\_id | The unique ID assigned by AWS |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
