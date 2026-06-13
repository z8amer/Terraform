terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.46.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-zain"
    key = "terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
    region =  "eu-north-1"
  
}
