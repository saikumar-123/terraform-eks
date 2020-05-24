#
# Provider Configuration


provider "aws" {
  region = var.aws-region
  shared_credentials_file = "/Users/sravya/.aws/credentials"
  profile = "default"
}

