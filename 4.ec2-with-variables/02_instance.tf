resource "aws_instance" "ec2" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"

  tags {
    Name = "class-instnace"
  }
}
