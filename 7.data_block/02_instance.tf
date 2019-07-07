data "aws_availability_zones" "all" {}

resource "aws_instance" "ec2" {
  //ami           = "${lookup(var.amis, var.region)}"
  ami           = "${data.aws_ami.rhel.id}"
  instance_type = "t2.micro"

  tags {
    Name = "class-instnace"
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
