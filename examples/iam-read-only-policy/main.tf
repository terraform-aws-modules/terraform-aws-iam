provider "aws" {
  region = "eu-west-1"
}

locals {
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
}

module "iam_policy" {
  source = "../../modules/iam-read-only-policy"

  name        = "example"
  path        = "/"
  description = "My read only example policy"

  allowed_services = local.allowed_services

  tags = {
    PolicyDescription = "Policy created using heredoc policy"
  }
}