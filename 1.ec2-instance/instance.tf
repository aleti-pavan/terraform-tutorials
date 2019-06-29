provider "aws" {
    region = "us-east-1"
    access_key = "AKIATFROX7GQ72E"
    secret_key = "l3LrgQUQhGrFyaVmhGlLDOOWYVrCD"
}

resource "aws_instance" "ec2" {

         ami = "ami-098bb5d92c8886ca1"
         instance_type = "t2.micro"
}
