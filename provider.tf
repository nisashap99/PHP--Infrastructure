terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3" {
    bucket         = "expense-project-env-dev"
    region         = "us-east-1"
    key            = "PHP--Infrastructure"
    dynamodb_table = "expense-project-env-dev"
  }
}

provider "aws" {
  region = "us-east-1"
}