provider "aws" {
  region     = "us-east-1"
  access_key = "access_key"
  secret_key = "secret_key"
}

resource "aws_instance" "ec2" {
  ami           = "ami-098bb5d92c8886ca1"
  instance_type = "t2.micro"

  tags {
    Name = "class-instnace"
  }
}
