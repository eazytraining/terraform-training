
data "aws_ami" "app_ami" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = [ "*ubuntu-bionic*" ]
  }
}

resource "aws_instance" "myec2" {
    ami = data.aws_ami.app_ami.id
    instance_type = var.instance_type
    tags = var.aws_common_tag
    availability_zone = var.AZ
    security_groups = var.security_groups
    key_name = "devops-anselme"

    provisioner "remote-exec" {
        inline = [ 
            "sudo apt update -y",
            "sudo apt install -y nginx"
        ]

        connection {
            type = "ssh"
            user = "ubuntu"
            private_key = file("./devops-anselme.pem")
            host = self.public_ip
        }
    }
}


