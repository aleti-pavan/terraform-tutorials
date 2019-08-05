provider "aws" {
  version    = "v2.17.0"
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

terraform {
  required_version = "0.11.11"


  backend "s3" {
    bucket         = "comic-lioness-ter-state"
    //encrypt        = true
    key            = "remote.tfstate"
    region         = "us-east-1"
    dynamodb_table = "comic-lioness-ter-state"
    access_key = "your_access_key" //these keys should be able to access s3/dynamodb resources
    secret_key = "your_access_key"
  }
}
