#Terraform v1.9.4 || Terraform 0.13 and later
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.65.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0dbc3d7bc646e8516"
  instance_type = "t2.micro"
  key_name      = "devops-eazytraining"
  tags = {
    Name = "ec2-eazytraining-tp2"
  }
}

