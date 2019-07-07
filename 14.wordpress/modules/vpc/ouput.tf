
output "vpc_id" {
value = "${aws_vpc.vpc.id}"
}

output "public_subnet1" {
value = "${aws_subnet.public1.id}"
}
output "public_subnet2" {
value = "${aws_subnet.public2.id}"
}
output "private_subnet1" {
value = "${aws_subnet.private1.id}"
}
output "private_subnet2" {
value = "${aws_subnet.private2.id}"
}
