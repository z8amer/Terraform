terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id = true


endpoints {
    ec2 = "http://localhost:4566"
    }

}

resource "aws_instance" "example" {
  ami                     = "ami-test"
  instance_type           = "t2.micro"

}
