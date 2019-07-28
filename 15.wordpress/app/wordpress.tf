
module "vpc" {
source = "../modules/vpc"
stack = "${var.stack}"
}

module "rds" {
source = "../modules/rds"
stack = "${var.stack}"
subnet_id1 = "${module.vpc.private_subnet1}"
subnet_id2 = "${module.vpc.private_subnet2}"
#subnet_ids = ["module.vpc.private_subnet1","module.vpc.private_subnet2"]
vpc_id = "${module.vpc.vpc_id}"
db_user = "${var.db_user}"
db_pass = "${var.db_pass}"
}

data "template_file" "phpconfig" {
  template = "${file("${var.file_path}")}"

  vars {
    db_port = "${module.rds.port}"
    db_host = "${module.rds.address}"
    db_user = "${module.rds.username}"
    db_pass = "${var.db_pass}"
    db_name = "${module.rds.name}"
  }
}



module "ec2" {

source = "../modules/ec2"
stack = "${var.stack}"
instance_type = "${var.instance_type}"
ssh_key = "${var.ssh_key}"
pub_subnetid1 = "${module.vpc.public_subnet1}"
vpc_id = "${module.vpc.vpc_id}"
vpc_cidr = "${module.vpc.vpc_cidr}"
db_name = "${module.rds.name}"
db_host = "${module.rds.address}"
db_user = "${module.rds.username}"
db_pass = "${var.db_pass}"
db_port = "${module.rds.port}"
php_file_path = "${var.file_path}"
userdata_file_path = "${var.userdata_file_path}"
config_rendered = "${data.template_file.phpconfig.rendered}"
}
