data "aws_availability_zones" "all" {}

resource "aws_instance" "ec2" {
  count = 1

  //ami           = "${lookup(var.amis, var.region)}"
  ami           = "${data.aws_ami.rhel.id}"
  instance_type = "t2.micro"
  key_name      = "2019-aws-class"
  user_data     = "${file("scripts/redhat_nginx.sh")}"

  tags {
    Name    = "class-instnace ${count.index}"
    Purpose = "${var.tag_list[count.index]}"
  }

  provisioner "file" {
    source      = "scripts/redhat_nginx.sh"
    destination = "/tmp/redhat_nginx.sh"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      port     = 22
      private_key = "${file("~/Downloads/2019-aws-class.pem.txt")}"
      host = "${aws_instance.ec2.public_ip}"
    }
  }
}

data "aws_ami" "rhel" {
  most_recent = true

  filter {
    name   = "name"
    values = ["suse-sles-15-v20180816-hvm-ssd-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["013907871322"] # Canonical
}
