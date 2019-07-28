
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
output "nat_id"{
value = "${aws_nat_gateway.nat.id}"
}

output "vpc_cidr"{
value = "${aws_vpc.vpc.cidr_block}"
}
