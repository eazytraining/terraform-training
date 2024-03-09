provider "aws" {
  region     = var.region
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

module "sg" {
  source = "./modules/sg"
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = "t4g.micro"
  aws_common_tag = {
    Name = "ec2-mini-projet-anselme"
  }
  security_groups = [ module.sg.aws_security_group_name ]
  AZ = var.AZ
}

module "eip" {
  source = "./modules/eip"
}

module "ebs" {
  source = "./modules/ebs"
  AZ = var.AZ
  size = var.size
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs.aws_ebs_volume_id
  instance_id = module.ec2.aws_instance_id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2.aws_instance_id
  allocation_id = module.eip.aws_eip_id
}
