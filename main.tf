// PROVIDERS

provider "aws" {
  region = "us-east-1"
}

// RESOURCES
resource "aws_key_pair" "main" {
  public_key = "${file("key.pub")}"
}
resource "aws_instance" "main" {
  ami = "ami-0cfee17793b08a293"
  instance_type = "t2.micro"
//  associate_public_ip_address = true
  key_name = "${aws_key_pair.main.key_name}"
  security_groups = ["allow_openvpn_port"]
}
resource "aws_security_group" "main" {
  name        = "allow_openvpn_port"
  description = "Allow 943 for OpenVPN connecion"
}
resource "aws_security_group_rule" "ingress_all" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.main.id}"
  to_port = 0
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "egress_all" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.main.id}"
  to_port = 0
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
}
resource "null_resource" "provisioner" {
  connection {
    type = "ssh"
    host = "${aws_instance.main.public_ip}"
    user = "ubuntu"
    port = "22"
    private_key = "${file("key")}"
  }
  provisioner "file" {
    source      = "install.sh"
    destination = "/home/ubuntu/install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo sh /home/ubuntu/install.sh",
      "sudo /usr/local/openvpn_as/scripts/sacli --key \"host.name\" --value \"${aws_instance.main.public_ip}\" ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli --key \"host.name\" --value \"${aws_instance.main.public_ip}\" Stop",
      "sudo /usr/local/openvpn_as/scripts/sacli --key \"host.name\" --value \"${aws_instance.main.public_ip}\" Start"
    ]
  }
}

// OUTPUTS
output "connect" {
  value = "https://${aws_instance.main.public_ip}:943/admin"
}
//output "file" {
//  value = "${data.template_file.config_file.rendered}"
//}
