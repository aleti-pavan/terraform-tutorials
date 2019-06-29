variable "region" {
  description = "AWS region to create resources"
  default     = "us-east-1"
  type = "string"
}

variable "access_key" {
  default = "AKIATF3X7GQ72E"
}

variable "secret_key" {
  default = "l3LrgQDOOWYVrCD"
}

variable "tags" {
  default = "terraform"
}

variable "amis" {
type = "map"
default = {
"us-west-1" = "ami-08949fb6466dd2cf3"
"us-east-2" = "ami-05220ffa0e7fce3d1"
"us-east-1" = "ami-098bb5d92c8886ca1"
}
}
