output "db_subnet"{
value = "${aws_db_subnet_group.mysql.id}"
}

output "address" {
value = "${aws_db_instance.db.address}"
}

output "endpoint" {
value = "${aws_db_instance.db.endpoint}"
}

output "id" {
value = "${aws_db_instance.db.id}"
}

output "name" {
value = "${aws_db_instance.db.name}"
}

output "port" {
value = "${aws_db_instance.db.port}"
}

output "username" {
value = "${aws_db_instance.db.username}"
}


output "db_access_from_ec2" {
  value = "mysql -h ${aws_db_instance.db.address} -P ${aws_db_instance.db.port} -u ${var.db_user} -p${var.db_pass}"
}
