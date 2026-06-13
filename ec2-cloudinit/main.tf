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
  region = "eu-north-1"
}

data "aws_ami" "ami_ec2" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
      name = "name"
      values = ["al2023-ami-2023*"]
  }

  filter {
      name = "architecture"
      values = ["x86_64"]
  }
}

resource "aws_security_group" "cloud-init_sg" {
  name        = "cloud-init_sg"
  
  ingress{
        description       = "HTTP from anywhere"
  	from_port         = 80
  	to_port           = 80
  	protocol          = "tcp"
  	cidr_blocks       = ["0.0.0.0/0"]
  }


  egress{
  	description       = "Allow all outbound traffic"
        from_port         = 0
  	to_port           = 0
  	protocol          = "-1"
  	cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "ec2_cloud-init" {
  ami = data.aws_ami.ami_ec2.id
  instance_type     = "t3.micro"
  security_groups = [aws_security_group.cloud-init_sg.name]
  key_name    = var.key_name
  user_data = file("${path.module}/cloud-init.yaml") 

  associate_public_ip_address = true
  }
