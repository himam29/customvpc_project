terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5"
    }
  }
  backend "s3" {
    bucket = "test21032024"
    dynamodb_table = "terraform-lock"
    region = "us-east-2"
    key = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-2"
}
