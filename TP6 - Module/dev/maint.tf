provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

terraform {
  backend "s3" {
    region     = "us-east-1"
    access_key = "YOUR-ACCESS-KEY"
    secret_key = "YOUR-SECRET-KEY"
    bucket = "terraform-backend-anselme"
    key = "anselme-dev.fstate"
  }
}

module "ec2" {
  source = "../modules/ec2module"
  instance_type = "t2.nano"
  aws_common_tag = {
    Name = "ec2-dev-anselme"
  }
  sg_name = "anselme-dev-sg"
}
