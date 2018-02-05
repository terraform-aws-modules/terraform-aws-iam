HTTP Security Group example
===========================

Configuration in this directory creates set of Security Group and Security Group Rules resources in various combination.

Data sources are used to discover existing VPC resources (VPC and default security group).

Usage
=====

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.
