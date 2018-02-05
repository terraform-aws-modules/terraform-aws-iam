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
