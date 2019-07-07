data "aws_availability_zones" "all" {}

resource "aws_instance" "ec2" {
  count = 1

  //ami           = "${lookup(var.amis, var.region)}"
  ami           = "${data.aws_ami.rhel.id}"
  instance_type = "t2.micro"

  user_data = <<-EOF
            		#!/bin/bash
                sudo yum update
                yum -y install nginx
                systemctl start nginx
                echo "<h1>Welcome to DevOps Classes, Keep Learning</h1>" | tee /usr/share/nginx/html/index.html
                EOF

  tags {
    Name    = "class-instnace ${count.index}"
    Purpose = "${var.tag_list[count.index]}"
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
