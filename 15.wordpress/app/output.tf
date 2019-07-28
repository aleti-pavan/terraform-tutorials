
output "vpc_id" {
value = "${module.vpc.vpc_id}"
}

output "public_subnet1" {
value = "${module.vpc.public_subnet1}"
}

output "public_subnet2" {
value = "${module.vpc.public_subnet2}"
}

output "vpc_cidr"{
value = "${module.vpc.vpc_cidr}"
}


output "db_access_from_ec2" {
  value = "${module.rds.db_access_from_ec2}"
}


output "address" {
value = "${module.rds.address}"
}

output "endpoint" {
value = "${module.rds.endpoint}"
}

output "id" {
value = "${module.rds.id}"
}

output "db_name" {
value = "${module.rds.name}"
}

output "db_port" {
value = "${module.rds.port}"
}

output "username" {
value = "${module.rds.username}"
}

output "Login" {
  value = "${module.ec2.Login}"
}

output "access" {
  value = "${module.ec2.access}"
}

output "we_sg_id"{
value = "${module.ec2.we_sg_id}"
}

output "ami_id" {
  value = "${module.ec2.ami_id}"
}
