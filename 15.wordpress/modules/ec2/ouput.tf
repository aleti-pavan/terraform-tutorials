output "Login" {
  value = "ssh -i ${aws_key_pair.keypair1.key_name} ubuntu@${aws_instance.ec2.public_ip}"
}

output "access" {
  value = "http://${aws_instance.ec2.public_ip}/index.php"
}

output "we_sg_id"{
value = "${aws_security_group.web.id}"
}

output "ami_id" {
  value = "${data.aws_ami.ubuntu.id}"
}
