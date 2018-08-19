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

## Outputs

| Name | Description |
|------|-------------|
| keybase_password_decrypt_command |  |
| keybase_password_pgp_message |  |
| keybase_secret_key_decrypt_command |  |
| keybase_secret_key_pgp_message |  |
| pgp_key | PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted) |
| this_iam_access_key_encrypted_secret | The encrypted secret, base64 encoded |
| this_iam_access_key_id | The access key ID |
| this_iam_access_key_key_fingerprint | The fingerprint of the PGP key used to encrypt the secret |
| this_iam_access_key_ses_smtp_password | The secret access key converted into an SES SMTP password |
| this_iam_access_key_status | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| this_iam_user_arn | The ARN assigned by AWS for this user |
| this_iam_user_login_profile_encrypted_password | The encrypted password, base64 encoded |
| this_iam_user_login_profile_key_fingerprint | The fingerprint of the PGP key used to encrypt the password |
| this_iam_user_name | The user's name |
| this_iam_user_unique_id | The unique ID assigned by AWS |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
