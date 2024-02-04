provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0dbc3d7bc646e8516"
  instance_type = "t2.micro"
  key_name      = "devops-anselme"
  tags = {
    Name = "ec2-anselme"
  }
}

