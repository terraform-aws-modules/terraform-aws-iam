provider "aws" {
  region = "eu-west-1"
}

locals {
  name = "ex-${basename(path.cwd)}"

  allowed_services_compute     = ["ec2", "ecr", "eks", "ecs", "lambda", "autoscaling", "elasticloadbalancing"]
  allowed_services_networking  = ["vpc", "route53", "route53domains", "route53resolver", "servicediscovery"]
  allowed_services_storage     = ["s3", "backup", "dynamo", "dms", "elasticfilesystem"]
  allowed_services_databases   = ["rds", "dynamo", "elasticache"]
  allowed_services_management  = ["cloudwatch", "events", "logs", "servicequotas", "ssm"]
  allowed_services_analytics   = ["es", "firehose", "kinesis", "kinesisanalytics", "redshift"]
  allowed_services_application = ["ses", "sns", "sqs", "xray", "applicationinsights", "application-autoscaling"]
  allowed_services_security    = ["iam", "acm", "kms", "secretsmanager"]

  allowed_services = concat(
    local.allowed_services_compute,
    local.allowed_services_networking,
    local.allowed_services_storage,
    local.allowed_services_databases,
    local.allowed_services_management,
    local.allowed_services_analytics,
    local.allowed_services_application,
    local.allowed_services_security
  )

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-iam"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# IAM Policy
################################################################################

module "read_only_iam_policy" {
  source = "../../modules/iam-read-only-policy"

  name        = local.name
  path        = "/example/"
  description = "My read only example policy"

  allowed_services = local.allowed_services

  tags = local.tags
}

module "read_only_iam_policy_doc" {
  source = "../../modules/iam-read-only-policy"

  create_policy    = false
  allowed_services = local.allowed_services

  tags = local.tags
}

module "read_only_iam_policy_disabled" {
  source = "../../modules/iam-read-only-policy"

  create = false
}
