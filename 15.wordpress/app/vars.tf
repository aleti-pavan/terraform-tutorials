variable "stack" {}

variable "region" {}

variable "access_key"{}
variable "secret_key"{}
variable "db_user"{}
variable "db_pass"{}





#Ec2 module variables

variable "instance_type" {}

variable "ssh_key" {}
variable "file_path" {
default = "../helpers/conf.wp-conf.php"
}
variable "userdata_file_path" {}
