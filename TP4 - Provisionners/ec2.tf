#Terraform v1.9.4 || Terraform 0.13 and later
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.65.0"
    }
  }
  required_version = "1.9.4"
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["../.secrets/credentials"]
  profile                  = "default"
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instance_type
  key_name        = "devops-eazytraining"
  tags            = var.aws_common_tag
  security_groups = [aws_security_group.allow_http_https.name]

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("../.secrets/devops-eazytraining.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_security_group" "allow_http_https" {
  name        = "eazytraining-sg"
  description = "Allow http and https inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all traffic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${self.public_ip} ID: ${aws_instance.myec2.id} AZ: ${aws_instance.myec2.availability_zone} > infos_ec2.txt"
  }
}
