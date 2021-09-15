terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.58.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = "Test"
      Project = "Role_Assumption"
      Owner = "James L"
    }
  }
}
