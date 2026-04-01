terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"   # tells Terraform to use AWS provider from HashiCorp
      version = "6.38.0"          # fixes the provider version (so no unexpected changes)
    }
  }
}

provider "aws" {
  region = "eu-west-1"            # AWS region where resources will be created (Ireland)
}