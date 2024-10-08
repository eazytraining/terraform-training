#Terraform v1.9.4 || Terraform 0.13 and later
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.65.0"
    }
  }
  required_version = "1.9.4"

  backend "s3" {
    region                   = "us-east-1"
    shared_credentials_files = ["../../.secrets/credentials"]
    profile                  = "default"
    bucket                   = "terraform-backend-eazy-tp6"
    key                      = "eazy-prod-tp6.tfstate"
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["../../.secrets/credentials"]
  profile                  = "default"
}

module "ec2" {
  source        = "../modules/ec2module"
  instance_type = "t2.micro"
  aws_common_tag = {
    Name = "ec2-prod-eazy-tp6"
  }
  sg_name = "eazy-prod-sg"
}
