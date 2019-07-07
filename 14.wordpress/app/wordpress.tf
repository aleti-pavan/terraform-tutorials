module "vpc" {
source = "../modules/vpc"
stack = "${var.stack}"
}
