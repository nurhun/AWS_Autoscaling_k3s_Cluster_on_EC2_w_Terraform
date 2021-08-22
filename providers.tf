terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #   version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider. Shared credentials file configured wth awscli conf file.
provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "default"
}