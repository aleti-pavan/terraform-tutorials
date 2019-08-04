provider "aws" {
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

terraform {
  required_version = "0.11.11"

  required_providers {
    aws = "2.22.0"
  }

  backend "s3" {
    bucket = "online-classes-remote-state"
    region = "us-east-1"
    key = "remote.state"
    dynamodb_table = "charmed-gopher-ter-state"

  }
}
