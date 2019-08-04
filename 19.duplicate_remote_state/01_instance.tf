resource "aws_instance" "ec2" {
  ami           = "ami-098bb5d92c8886ca1"
  instance_type = "t2.micro"

  tags {
    Name = "class-instnace"
  }
}
