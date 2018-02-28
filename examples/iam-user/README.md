# IAM user example

Configuration in this directory creates IAM user with a random password and a pair of IAM access/secret keys.
User password and secret key is encrypted using public key of keybase.io user named `test`.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.
