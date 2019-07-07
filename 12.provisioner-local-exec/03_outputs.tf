output "public_ip" {
  value     = "${aws_instance.ec2.*.public_ip}"
  sensitive = true
}

output "login" {
  value = "ssh -i 2019-aws-class ec2-user@"
}

output "private_ip" {
  value = "${aws_instance.ec2.*.private_ip}"
}

output "public_dns" {
  value = "${aws_instance.ec2.*.public_dns}"
}

output "azs" {
  value = "${data.aws_availability_zones.all.*.names}"
}

output "ami" {
  value = "${aws_instance.ec2.*.ami}"
}
