terraform {
  required_version = ">= 0.12.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.23"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}
